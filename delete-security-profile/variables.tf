###########################################################################
# Input variables
###########################################################################

variable "SUFFIX" {
  description = "Added name to each deployed resource"
}
variable LOCATION{
  description = "Azure region"
}
variable "REGION"{
  description = "Azure region as city, i.e.germanywestcentral with Frankfurt as city"
}
###########################################################################
#Static Variables FortiManager and FortiGate
###########################################################################
variable "adom" (
  type = string	
  defeult = "azure_networkhub"
  description = "The name of the adom defeults to 'root'"
}

variable "vdom" {
  type = string	
  default	= "root"	
  description = "The name of the vdom defaults to 'root'*
}
varlable "resource_group_name" {
  type = string	
  description = "The resource group nane of spoke Vnet"
  }