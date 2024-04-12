######################################################################################################
#
# FortiGate Cloud Initial configuration using terraform
#
######################################################################################################
######################################################################################################
# Interims solution as long as the names are not unique in all regions
# name differs in regon pek only
######################################################################################################

locals {

computer_name_p = (var.LOCATION--"chinanorth2" ? "VM-SFYMAEPNP$(upper(var.REGION))$(var.SUFFIX)F1-$(var.SUFFIX)”:"SFYMAEPNP$(upper(var.REGION)}${var.SUFFIX)F1")
computer_name_s = (var.LOCATION--"chinanorth2" ? "VM-SFYMAESNP$(upper(var.REGION))$(var.SUFFIX)F1-$(var.SUFFIX)”:"SFYMAESNP$(upper(var.REGION)}${var.SUFFIX)F1")
fgt_p_custom_data = {
      fgt_vm_name	 = "VM-SFYMAEPNP${upper(var.REGION)}${var.SUFFIX)F1-$(var.SUFFIX)”	
      fgt_license_file = $var.FGT_BYOL_LICENSE_FILE_P	
      fgt_username = var.USERNAME	
      fgt_ssh_public_key = var.FGT_SSH_PUBLIC_KEY_FILE 
      fgt_external_ipaddr = var.fgt_ipaddress_p["1"]
      fgt_external_mask = split("/",var,subnet["1"])[1]
      fgt_external_gw	= var.gateway_ipaddress["1”]	
      fgt_internal_ipaddr = var.fgt_ipaddress_p["2"]
      fgt_internal_mask = split("/",var.subnet["2"])[1]
      fgt_internal_gw	= var.gateway_ipaddress["2"]	
      fgt_hasync_ipaddr	= var.fgt_ipaddress_p["3"]	
      fgt_hasync_mask	= split("/",var,subnet["3"])[i]	
      fgt_hasync_gw	= var.gateway_ipaddress["3"]
      fgt_mgnt_ipaddr	= var.fgt_ipaddress_p["4"]	
      fgt_=gmt_mask	= split("/",var,subnet[“4"])[1]	
      fgt_mgmt_EW	= var.gateway_ipaddress["4"]	
      fgt_ha_peerip	= var.fgt_ipaddress_s["3"]	
      fgt_protected_net = var.subnet["5"]
      vnet_network = var.vnet	
      ha_priority	= var.fgt_ha_priority_p	
      dns_ip_p	= var.dns_ip_p	
      dns_ip_s	= var.dns_ip_s	
      fgt_tacacs_key = var.TACACS_AUTH_KEY	
      fgt_qmfwco0_pwd	 = var.PASSWORD	
      fgt_ha_group_name	= "AzureHA${upper(var,REGION)}${var.SUFFIX}F1"	
      fmg_mgmt_fqdn_1	= var.fmg_config["fqdn_1"]	
      fmg_mgmt_ip_1 = var.fmg_config["ip_1"]
      fmg_mgmt_fqdn_2	=var.fmg_config["fqdn_2"]	
      fmg_mgmt_ip_1	= var.fmg_config["ip_1"]	
      fmg_mgmt_ip_2	= var.fmg_config["ip_2"]	
      fmg_register_device=var.fmg_config["reg_device"]
      }
      fgt_s_custom_data = {
      fgt_vm_name	="VM-SFYMAESNP${upper(var.REGION)}${var.SUFFIX}F1-${var.SUFFIX}"	
      fgt_license_file = var.FGT_BYOL_LICENSE_FILE_S	
      fgt_username = var.USERNAME	
      fgt_ssh_public_key = var.FGT_SSH_PUBLIC_KEY_FILE fgt_external_ipaddr = var.fgt_ipaddress_s["1"]
      fgt_external_mask = split("/",var.subnet["1"])[1]
      fgt_external_gw	= var.gateway_ipaddress["1"]	
      fgt_internal_ipaddr =var.fgt_ipaddress_s["2"]
      fgt_internal_mask= split("/" ,var.subnet["2"])[1]
      fgt_internal_mask	= split("/",var.subnet["2"])[1]	
      fgt_internal_gw	= var.gateway_ipaddress["2"]	
      fgt_hasync_ipaddr	= var.fgt_ipaddress_s["3"]	
      fgt_hasync_mask	= split("/" ,var.subnet["3"])[1]	
      fgt_hasync_gw	= var.gateway_ipaddress["3"]	
      fgt_mgmt_ipaddr	= var;fgt_ipaddress_s["4"]	
      fgt_mgmt_mask	= split("/",var.subnet["4"])[1]	
      fgt_mgmt_gw	= var,gateway_ipaddress["4"]	
      fgt_ha_peerip	= var.fgt_ipaddress_p["3"]	
      fgt_protected_net	=var.subnet["5"]	
      vnet_network = var.vnet	
      ha_priority	= var.fgt_ha_priority_s	
      dns_ip_p = var.dns_ip_p	
      dns_ip_s =var.dns_ip_s	
      fgt_tacacs_key = var.TACACS_AUTH KEY	
      fgt_qmfwco0_pwd	= var.PASSWORD	
      fgt_ha_group_name	= "AzureHA${upper(var.REGION)}${var.SUFFIX}F1"	
      fmg_mgmt_fqdn_1	=var.fmg_config["fqdn_1"]	
      fmg_mgmt_fqdn_2	= var,fmg_config["fqdn_2"]	
      fmg_mgmt_ip_1	= var.fmg_config["ip_1"]	
      fmg_mgmt_ip_2	= var.fmg_config["ip_2"]	
      fmg_register_device = var.fmg_config["reg_device"]
  }
}

#######################################################################################################
# Resource Group
#######################################################################################################

data "azurerm_resource_group" "rg_networkhub" {
    name	"RG-NETWORKHUB-${upper(var.REGION)}-${var.SUFFIX}"	
}
data "azurerm_virtual_network" "vnet_networkhub" {
    name	= "VNET-HUB-${upper(var.REGION)}-${var.SUFFIX}"	
    resource_group_name = data,azurerm_resource_group.rg_networkhub.name
}
data "azurerm_route_table" "rt_firewall" { 
    name ="DEFAULT-2-FIREWALL-${upper(var.REGION)}-${var.SUFFIX}"
    resource_group_name = data.azurerm_resource_group.rg_networkhub.name
}
#######################################################################################################
# Service Endpoint'Storage Policy
#######################################################################################################

resource "azurerm_subnet_service_endpoint_storage_policy" "sesp_firewall" {
    name = "SESP-RG-SFYMAEPNP${upper(var.REGION)}${var.SUFFIX}F1-${var.SUFFIX}"
    resource_group_name = azurerm_resource_group.rg_fortigate.name
    location	= azurerm_resource_group.rg_fortigate.location	
    definition {
      name = "Microsoft.storage"	
      service_resources = [
      azurerm_resource_group.rg_fortigate.id
      ]
      }
    }
#######################################################################################################
# Firewall Subnet
#######################################################################################################


resource "azurerm_subnet" "subnet1" {
    name = "SNET-FIREWALL-OUTSIDE-${upper(var.REGION)}-${var.SUFFIX}"	
    resource_group_name	= data.azurerm_resource_group.rg_networkhub.name	
    virtual_network_name	-data.azurerm_virtual_network.vnet_networkhub.name	
    address_prefixes	，=[var.subnet["1"]]	
    service_endpoints	=["Microsoft.Storage" ]	
}
resource "azurerm_subnet" "subnet2" {
    name = "SNET-FIREWALL-INSIDE-${upper(var.REGION)}-${var.SUFFIX}"	
    resource_group_name	= data.azurerm_resource_group.rg_networkhub.name	
    virtual_network_name = data.azurerm_virtual_network.vnet_networkhub.name	
    address_prefixes = [var.subnet["2"]]	
    service_endpoints	= ["Microsoft.Storage"]	
    service_endpoint_policy_ids = [azurerm_subnet_service_endpoint_storage_policy.sesp_firewal1.id]
  }
resource  "azurerm_subnet" "subnet3" {
    name = "SNET-FIREWALL-HA-${upper(var.REGION)}-${var.SUFFIX}"	
    resource_group_name	= data.azurerm_resource_group.rg_networkhub.name	
    virtual_network_name	data.azurerm_virtual_network.vnet_networkhub.name	
    address_prefixes = [var.subnet["3"]]	
    service_endpoints = ["Microsoft.Storage"]	
    service_endpoint_policy_ids = [azurerm_subnet_service_endpoint_storage_policy.sesp_firewal1.id]
}


resource "azurerm_subnet" "subnet4" { 
    name = "SNET-FIREWALL-MGMT-${upper(var.REGION))-$(var.SUFFIX}"
    resource_group_name	= data.azurerm_resource_group.rg_networkhub.name	
    virtual_network_name = data.azurerm_virtual_network.vnet_networkhub.name	
    address_prefixes = [var.subnet["4"]]	
    service_endpoints	= ["Microsoft.Storage" ]	
    service_endpoint_policy_ids = [azurerm_subnet_service_endpoint_storage_policy.sesp_firewall.id]
    }

#######################################################################################################
# Route table for Firewall Outside Subnet
#######################################################################################################



#######################################################################################################
# Route table for Firewall Inside, MGMT,HA Subnet
#######################################################################################################




#######################################################################################################
# Public IPs for FortiGate VMs
#######################################################################################################

