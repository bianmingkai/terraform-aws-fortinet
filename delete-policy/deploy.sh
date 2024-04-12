#!/bin/bash 
echo"

##############################################################################################################################
#
# Check VNet / security profile uniqueness
##############################################################################################################################

# Stop running when command returns error 
set -e

##############################################################################################################################
# Environment
##############################################################################################################################
export ENVIRONMENT=$1

##############################################################################################################################
# Execute terraform plan w/o apply
##############################################################################################################################

export PLAN_WO_APPLY=$2
##############################################################################################################################

# Azure VNet name = Name of Firewall rule and from / to firewall using the key value
##############################################################################################################################

export VNET=$3 
export FIREWALL=$4

##############################################################################################################################
# FortiManager Configuration
##############################################################################################################################

export FORTIMANAGER_ACCESS_HOSTNAME-$5 
export FORTIMANAGER_ACCESS_USERNAME=$6 
export FORTIMANAGER_ACCESS_PASSWORD-$7 
export FORTIMANAGER_INSECURE-"false"
export FORTIMANAGER_CA_CABUNDLE="../../networkhubs/global/cabundle/BMW_Group_Root_CA_V3.crt”

##############################################################################################################################
# Store error message in file
##############################################################################################################################

export TF_LOG-ERROR
export TF_LOG_PATH-error.log
##############################################################################################################################
# Store plugins in cache folder to minimize downloads from the Internet
##############################################################################################################################

export TF_CLI_CONFIG_FILE-../../networkhubs/global/terraform.d/plugin-cache-folder-config.tfrc

##############################################################################################################################
#Chark Parameters
##############################################################################################################################
echo ""
echo "==> Create backend.hcl file" 
echo ""
cat <<END >backend.hcl
path = "terraform.tfstate" 
END

echo ""
echo "--> Terraform init" 
echo ""
terraform init -backend-config-backend.hcl -input-false


echo ""
echo "==> Terraform providers" 
echo ""
terraform providers

echo "--> INFO: Terraform plan not supported for Security Profile movement!" 
echo "Just run apply for querying firewall objects" 
echo ""
terraform apply -auto-approve \
                -target fortimanager_json_generic_api.find_firewall_policies \
                -var-file "../../networkhubs/$ENVIRONMENT/$ENVIRONMENT.tfvars" \ 
                -var "vnet_name=$VNET" \ 
                -var "firewall=$FIREWALL"
if [ "${PLAN_WO_APPLY)"== "apply"] 
then
    echo ""
    echo "==> Terraform apply" 
    echo ""
    terraform apply -auto-approve \
                    -var-file "../../networkhubs/$ENVIRONMENT/$ENVIRONMENT.tfvars" \ 
                    -var "vnet_name-$VNET" \ 
                    -var "firewall-$FIREWALL"
    if [[ $? != 0]]; 
    then
    echo "--> ERROR: Deployment failed ..."
  exit $rc;
    fi
  fi


echo ""
echo "==> Remoe .terraform .terraform.lock.hcl terraform.tfstate"
echo ""
rm -fr .terraform .terraform.lock.hcl terraform.tfstate

