############################################################################################################
# FortiGate Cloud initial configuration using Terraform
############################################################################################################

############################################################################################################
# Terraform Provider and Version
############################################################################################################


terraform{
  required_version="~> 1.4.6" 
  requined_providers{ 
     fortios = {
      source = "fortinetdev/fortios" 
      version = "=1.16.0"
      }
local = {
  source = "hashicorp/local* 
  version = "2.4.0"
  }
}


backend "local" {}

provider "fortios"{
}