#!/bin/bash 
echo"

##############################################################################################################################
#
# Check VNet / security profile uniqueness
##############################################################################################################################

# Stop running when command returns error 
set -e

##############################################################################################################################

# Proxy
proxy_user=$1 
proxy_pwd=$2
export http_proxy-http://$proxy_user:$proxy_pwd@proxy.muc:8080 
export https_proxy-http://$proxy_user:$proxy_pwd@proxy.muc:8080

##############################################################################################################################
# Environment

export ENVIRONMENT-$3

##############################################################################################################################

# Azure WNet name

##############################################################################################################################

export VNET-$4

##############################################################################################################################

# FortiManager Configuration

##############################################################################################################################
export FORTIMANAGER_ACCESS_HOSTNAME=$5 
export FORTIMANAGER_ACCESS_USERNAME=$6 
export FORTIMANAGER_ACCESS_PASSWORD=$7 
export FORTIMANAGER_INSECURE="false"
export FORTIMANAGER_CA_CABUNDLE-"../../networkhubs/global/cabundle/BMW_Group_Root_CA_V3.crt"

##############################################################################################################################
# Store plugins in cache folder to minimize downloads from the Internet
##############################################################################################################################

 export TF_CLI_CONFIG_FILE=../../networkhubs/global/terraform.d/plugin-cache-folder-config.tfrc

##############################################################################################################################
Check Parameters
##############################################################################################################################

echo ""
echo "==> Create backend.hcl file" 
echo ""
cat <<END >backend.hcl
path = "terraform.tfstate" 
END

echo ""
echo "=-> Starting Terraform deployment" 
echo ""
PLAN="terraform.tfplan"




echo ""
echo "==> Terraform init" 
echo ""
terraform init -backend-config=backend.hcl -input=false


echo ""
echo "=-> Terraform providers" 

echo ""
terraform providers

echo ""
echo "==> Terraform plan" 
echo ""

terraform plan --out "$PLAN” \
               -var-file "../../networkhubs/$ENVIRONMENT/$ENVIRONMENT.tfvars" \ 
               -var "vnet_name=$VNET"

if  [[ $?!= 0 ]]; then
echo "--> ERROR: Dry run failed ..." 
exit $rc; 
fi

echo ""
echo "=-> Terraform apply" 
echo ""

terraform apply "$PLAN” 

if [[ $? != 0 ]];
then
   echo "--> ERROR: Apply failed ..."
exit $rc; 
fi
export TF_VAR_RESPONSE=$(terraform output group_response_all) 

echo $TF_VAR_RESPONSE

echo "Check if the VNet name is in the response..."

if [[ $TF_VAR_RESPONSE"-~ $VNET 1]; then
     export MSG-"A security profile for VNet $VNET already exist. Please provide a unique VNet name!" 
     echo $MSG
     echo $MSG > error.log 
     exit 1 
else
echo "INF01: VNet $VNET not exist. Creation is allowed!" 
fi

echo""
echo "--> Remove .terraform .terraform.lock.hcl terraform.tfstate" 
echo ""
rm -rf .terraform .terraform.lock.hcl terraform.tfstate 
rm $PLAN