#####################################################################################################
/*	
locals {
cidr_ranges = [
  for address_space in data.azurerm_virtual_network.spake_vnet_ip_ranges.address_space
  #TODO switch with VPC address range
  "${var.vpc.id}_${replace(address space,"/","_"}}"

output "cidr_ranges_out"{
   value = local.cidr_ranges
   #TODO switch to read cidr range from VPC_id
   }
resource "fortios_fmg_firewall_security policy" "firewall_policy" {
 name	=var.vpc.id	
 srcaddr = local.cidr_ranges
 #TODO switch to read cidr range from VPC id
 srcintf	-["internal"]	
 dstaddr	= ["all"]	
 dstintf	- ["external"]	
 service	=["HTTP","HTTPS"]	
 action	="accept"	
 schedule	=["always"]	
 utm_status	="enable"	
 logtraffic	="utm"	
 logtraffic_start ="enable"
 profile_type	- "group"	
 profile_group	=[var .vpc.id]	
 package_name	="sfyawepnp${var.dict_location_short name[var regto	
 #TODO orangize varable structure for policy package 
 adom =var.adom
 depends_on = [
  fortios_fmg_firewall_object_address.firewall_addresses,
  fortios_fmg_jsonrpc_request.profile_group
   ]
  }
 */