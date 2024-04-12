#/bin/bash
echo "
#################################################################################################
#
# FortiGate Deployment
#
#################################################################################################

''


# Stop running when command returns error

set -e

#################################################################################################
# Azure Service Principal
#################################################################################################

export ARM_CLIENT_ID=$1
export ARM_CLIENT_SECRET=$2 
export ARM_SUBSCRIPTION_ID-$3 
export ARM_TENANT_ID=$4 
export ARM_ENVIRONMENT-$5

#################################################################################################
# Proxy

#################################################################################################

proxy_user=$6 
proxy_pwd=$7
export http_proxy=http://$proxy_user:$proxy_pwd@proxy.muc:8080 
export https_proxy=http://$proxy_user:$proxy_pwd@proxy.muc:8080


#################################################################################################
#Environment
#################################################################################################

export ENVIRONMENT=$8
# subscription name is needed for the unique storage account name
# without dash and understore, only with letters and numbers
# e.g. Subscription with nameFG-85_TEST must given as fg85test 
export SUBSCRIPTION NAME=$9

#################################################################################################
# Execute terraform plan w/o apply

#################################################################################################

export PLAN_WO_APPLY=${10}

#################################################################################################
# Azure Resource Group and VNet Name
#################################################################################################

export RESOURCE_GROUP=${11}
export VNET=${12}

#################################################################################################
# FortiManager Configuration
#################################################################################################

export FORTIOS_FMG_HOSTNAME-${13} 
export FORTIOS_FMG_USERNAME-${14} 
export FORTIOS_FMG_PASSWORD-${15} 
export FORTIOS_FMG_INSECURE-"false"
export FORTIOS_FNG_CABUNDLE="../../networkhubs/global/cabundle/BMW_Group_Root_CA_V3.crt”
#################################################################################################
# Store error message in file
#################################################################################################

export TF_LOG=ERROR
export TF_LOG_PATH=error.log
#################################################################################################
#Store plugins in cache folder to minimize downloads from the Internet
#################################################################################################
export TF_CLI_CONFIG_FILE-../../networkhubs/global/terraform.d/plugin-cache-folder-config.tfrc

#################################################################################################
#Check Parameters
#################################################################################################
echo ""
echo "==> Create backend.hcl file" 
echo ""
cat <<END >backend.hcl 
path = "terraform.tfstate" 
END

echo ""
echo "==> Starting Terraform deployment" 
echo ""
PLAN="terraform.tfplan"

echo ""
echo "==> Terraform init""
echo ""
terraform init -backend-config-backend.hcl -input=false


echo ""
echo "==> Terraform providers"
echo ""
terraform providers


echo ""
echo "==> Terraform plan" 
echo ""
echo "==> INFO: Terraform plan not supported for Security Profile deletion!" 
echo "Just run apply for querying firewall objects" 
echo ""
terraform apply -auto-approve \
                -target fortios_fmg_jsonrpc_request.find_firewall_policies \ 
                -target fortios_fmg_jsonrpc_request.find_firewall_addresses \ 
                -target fortios_fmg_jsonrpc_request.find_profile_groups\
                -target fortios_fmg_jsonrpc_request.find_webfilter_urlfilters \ 
                -target fortios_fmg_jsonrpc_request.find_webfilter_profiles\ 
                -var-file"../../networkhubs/$ENVIRONMENT/$ENVIRONMENT.tfvars”\ 
                -var "resource_group_name-$RESOURCE_GROUP”\ 
                -var "vnet_name=$VNET"
if [ "${PLAN_WO_APPLY}" == "apply" ]; then
    terraform apply -auto-approve\
            -var-file "../../networkhubs/SENVIRONMENT/$ENVIRONMENT.tfvars"\ 
            -var "resource_group_name=$RESOURCE_GROUP"\ 
            -var "vnet_name-$VNET" 
            if [[ $? |= 0 ]]; then
                echo"-->ERROR: Deployment failed..." 
                exit $rc;
            fi 
fi
echo ""
echo "==> Remove .terraform .terraform.lock.hcl terraform.tfstate" 
echo ""
rm-rf .terraform .terraform.lock.hcl terraform.tfstate

