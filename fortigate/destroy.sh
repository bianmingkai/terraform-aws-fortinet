#/bin/bash
echo "
#################################################################################################
#
# FortiGate Destroy
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
# FortiGate Configuration
#################################################################################################

export FORTIOS_FMG_HOSTNAME-${13} 
export FORTIOS_FMG_USERNAME-${14} 
export FORTIOS_FMG_PASSWORD-${15} 
export FORTIOS_FMG_INSECURE-"false"
export FORTIOS_FNG_CABUNDLE="../../networkhubs/global/cabundle/BMW_Group_Root_CA_V3.crt”
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
resource_group_name = "R6-TERRAFOR
storage_account_name = "sttf$SUBSCRIPYION_NAME"
container_name	= "aciterraform"	
key	"SENNTRONMENT/fortigate-$(ENVIRONMENT).tfstate"	
END


echo ""
eche "==> Starting Terraform destroy" 
echo ""
PLAN-"terraform.tfplan”


echo ""
echo"==> Terraform init"
echo ""
terraform init -backend-config=backend.hcl -input=false 


echo ""
echo "==> Terraform plan -destroy"
echo ""
terraform plen -destroy --out "$PLAN" \
               --var-file "../../networkhubs/$ENVIRONMENT/$ENVIRONIENT.tfvars” \ 
               --var "USERNME=x" \ 
               --var "PASSHORD=x" \
               --var "TACAKCS_AUTH_KEY=x"


if ["${PLN_WD_APPLY}" == "apply" ] 
then
    echo ""
    echo "==> Terreform destroy" 
    echo ""
    terraform destroy -auto-approve \
                      -var-file "../../networkhubs/$ENVIRONMENT/$ENVIRONMENT.tfvars" \
                      -var "USERNAME=x" \
                      -var "PASSWORD=x" \
                      -var "TACACS_AUTH_KEY=x"
fi
echo ""
echo "==> Remove terrafore.tfplan and .terrafors" 
echo ""
rm -fr .terraform .terreform.lock.hcl 
rm $PLAN