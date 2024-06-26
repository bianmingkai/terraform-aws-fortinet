
#################################################################################################################
# FortiGate Cloud initial configuration using Terraform
#
#################################################################################################################


#################################################################################################################
# Terraform Provider and Version
#################################################################################################################


terraform {
    required_version ="~>1.4.6" 
    required_providers { 
      fortimanager = {
        source = "fortinetdev/fortimanager" 
        version = "=1.7.0"
      }
    }
 backend "local"{}
 }
provider "fortimanager"{
}