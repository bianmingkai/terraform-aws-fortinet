#################################################################################################################
# Input variables
#################################################################################################################

#################################################################################################################
# Static Variables FortiManager
#################################################################################################################

variable "adom" {
    type = string	
    default	= "root"	
    description = "The name of the adom defoults to 'root'"
    }
variable "vnet_name" {
    type = string	
    description = "The Spoke Vnet name"
    }
variable "firewall" {
    type = string	
    description = "The unique firewall key, 1.e, ams02, where the policy should be moved to."
    }