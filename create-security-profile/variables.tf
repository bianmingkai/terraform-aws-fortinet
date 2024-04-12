##########################################################################################################################
# Input Variables
##########################################################################################################################

variable "spoke-vpc" { 
    type = object ({
     id = string
    })
    default = { 
    id = ""
    description = "vpc name or id as input"
   }
}
##########################################################################################################################
# Static Nariaties fortimanager and FortiGate
##########################################################################################################################

variable "fmg" {
  type = string
  default	= null
  description =	"The fodn of the fortimanagep defaults to null"
}
variable "adom" {
  type =	String	
  default	= "root"	
  description	= "The hame of the adom defaults to root"
}
variable "vdom" {
  type	= string	
  default	= "root"	
  description = "The name of the vdom defaults to 'root'"
}

variable "vdom" {
   type = string
   default = "root"
   description = "the name of the vdom defaults to 'root'"
}



##########################################################################################################################
#
#
#
#                                          AWS Variables Descriptions 
#
#
##########################################################################################################################

variable "environment" {	
  description = "choosen environment e.g. bmwgroup-0-euwe1"
  type = string	
  validation {
    condition	    = startswith(var.environment,"bmwgroup") || startswith(var.environment,"bmwcn")	
    error_message = "environment name is not correct"
    }
}
variable "region" {
  description = "current region"
  type	      = string	
}


variable "vpc" {
   description = "VPC ID // Input value" 
   type = object({ 
      id = string
})
default = {
   id = "xxx"
}
validation {
  condition	= substr(var.vpc.id,0,4) == "vpc-"	
  error_message = "vpc-id input validation failed"
  }
 }


variable "tgw" {
  description = "Transit Gateway ID to attach to" 
  type= object({
    id = string 
    index = number
   })
validation {
  condition   = substr(var.tgw.id,0,4) == "tgw-"
  error_message = "tgw_id input validation failed"
}
}


