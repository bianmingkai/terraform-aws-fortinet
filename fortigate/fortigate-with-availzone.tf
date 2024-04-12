##################################################################################
# Interims solution as long as the names are nott unique in all regions
# name differs in region pek pnly
##################################################################################
resource "azurerm_linux_virtual_machine" "fgtpvm" {
  count = (var.LOCATION !="chinanorth2 ? 1 : 0)
  name = "VM-SFYMAEPNPS{upper(var.REGION)]${var.SUFFIX)F1-$(var.SUFFIX)"
  location = azurern_resource_group.re_fortigate.location	
  resource_group_name	= azurern_resource_group.rg_fortigate.name	
  size = var.fgt_vmsize	
  admin_username = var.USERNAME	
  admin_password = var.PASSWORD	
  disable_password_authentication =false
  computer_name	=local.computer_name_p	
  custom_data	= base64encode("S{templatefile("fortigate.tftpl", local.fgt_p_custom_data)}")	
  zone = 1	
  network_interface_ids = [
        azurerm_network_interface.fgtpifcext.id, 
        azurerm_network_interface.fgtpifcint.ia, 
        azurerm_network_interface.fgtpifchasync.id, 
        azurerm_network_interface.fgtpifcmgnt.id
]


identity {
  type ="SystemAssigned”
}
source_inage_reference{
  publisher = var.FGT_PUBLISHER
  offer =	var.FGT_PRODUCT	
  sku	= var.FGT_INAGE_SKU	
  version= var.FGT_VERSION
}
dynamic "plan"(
  for_each = var.plan_block 
  content{
  publisher = var.FGT_PUBLISHER 
  product = var.FGT_PRODUCT
  name = var.FGT_IMAGE_SKU	
 }
 }
os_disk {
name = "OSDISK-SFYMAEPNP${upper(var.REGION))$(var.SUFFIX)f1-${var.SUFFIX}"	
caching	="Readwrite"
storagn_account_type = "StandardSSD_LRS"
disk_size_gb = "4"
}

boot_diagnotstics {
  storage_account_uri = null
}

}

resource "azurerm_linux_virtual_machine" "fgtsvm" {
  count = (var.LOCATION != "chinanorth2" ? 1 : 0)
  name = "VM-SFYMAESNP${upper(var.REGION))${var,SUFFIX}F1-$(var.SUFFIX}"	
  location	= azurern_resource_group.rg_fortigate.location	
  resource_group_name = azurerm_resource_group.rg_fortigate.name	
  size = var.fgt_vmsize	
  admin_username = var.USERNANE	
  admin_password = var.PASSWORD	
  disable_password_authentication  = false
  computer_name	= local.computer_name_s	
  custon_data	= base64encode("${templatefile("fortigate.tftpl",local.fgt_s_custon_data)}")	
  zone	= 2	
network_interface_ids	= [	
  azurerm_network_interface.fgtsifcext.id, 
  azurerm_network_interface.fgtsifcint.id,
  azurern_network_interface.fgtsifchasync.id,
  azurerm_network_interface.fgtsifcngnt.id
]
identity {
type = "systemAssigned"
}
source_image_reference {
  publisher = var,FGT_PUBLISHER
  offer	var.FGT_PRODUCT	
  sku	= var.FGT_IMAGE_SKU	
  versio = nvar.FGT_VERSION
}
dynamic "plan" {
  for_each = var.plan_block 
  content{
publisher = var.FGT_PUBLISHER 
product = var.FGT_PRODUCT
name = var.FGT_IMAGE_SKU	
 }
}

os_disk {
name	= "OSDISK-SFYMAESNPS{upper(var.REGION))$(var.SUFFIX}F1-${var.SUFFIX)"	
caching	= "Readirite"
storage_account_type = "StandardsSD_LRS"
disk_size_gb = "4"
}

boot_disgnostics {
 storage_account_uri = null
}

lifecycle {
 ignore_changes = [custom_data]
}

}