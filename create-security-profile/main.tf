#####################################################################################################################
#
#   FortiGate CLoud inital configuration using Terraform
#
#####################################################################################################################

#####################################################################################################################
#   terraform provider and version
#####################################################################################################################


terraform {
#required_version-"~>1.6.0" 
required_providers {
 aws = {
    source ="hashicorp/aws"
    version = "~> 5.0" #"4.53.0"
    }
   fortios = {
   source ="fortinetdev/fortios" 
   version ="1.19.0"
    }
   }
   backend "s3" {
     bucket ="ntwlk-aws-int" 
     region = "eu-west-1"
     }
}
 provider "aws" {# INT Role: arn:aws:iam::284674420925:role/fpc/UserFull
}
 provider "fortios" {
  fmg_hostname = "var.fmg" 
  fmg_insecure = "true"
 }