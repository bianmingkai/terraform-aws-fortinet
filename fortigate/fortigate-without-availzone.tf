resource "azurerm_availability_set" "fgtavset" { 
  count = (var.LOCATION=="chinanorth2" ? 1 : 0)
  name = "AVAIL-FIREWALL-S(upper(var.REGION))-$(var.SUFFIX)*	
  location	= azurerm_resource_group.rg_fortigate.location	
  managed	= true	
  platform_fault_domain_count = 2
  resource_group_name	 =azurerm_resource_group.rg_fortigate.name	
}

resource "azurerm_linux_virtual_machine"“fgtpvmas" { 
  count = (var.LOCATION =="chinanorth2” ? 1 : 0)
  name	= local.computer_nane_p	
  location	 azurerm_resource_group.rg_fortigate.location	
  resource_group_name	= azurerm_resource_group.rg_fortigate.name	
  size = var.fgt_vmsize	
  admin_username = var.USERNAME	
  admin_password = var.PASSWORD	
  disable_password_authentication = false
  computer_name = local.computer_name_p	
  custon_data	 = bases4encode("s{templatefile ("fortigate.tftpl", local.fgt_p_custon_data)}")	
  availability_set_id	= azurern_availability_set.fgtavset[0].1d	
  network_interface_ids	= [	
    azurerm_network_interface.fgtpifcext.id,
    azurerm_network_interface.fgtpifcint.id, 
    azurern_network_interface, 
    fgtpifchasync.id, 
    azurenn_network_interface.fgtpifcmgnt.id
    ]
identity {
  type ="SystemAssigned”
}
source_image_reference {
  publisher =var.FGT_PUBLISHER
  offer	=var.FGT_PRODUCT	
  sku	-var.FGT_IMAGE_SKU	
  version-var.FGT_VERSION
}
os_disk {
  name = "OSDISK-SFYMAEPNP${Upper(var ,REGION)]$(var.SuFFIX)F1-${var.SUFFIX)"	
  caching	= "Readwrite"	
  storagn_account_type = "StandardsSD_LRS"
  disk_size_gb	4"	
}
boot_diagnostics {
  storage_account_uri = null
}

lifecycle {
  ignore_changes = [custom_data]
}

}

resource "azurerm_linux_virtual_machine""fgtsvmas" { 
  count = (var.LOCATION == "chinanorth2" ? 1 : 0)
  name	= local.computer_name_s	
  location = azurerm_resource_group.rg_fortigate.location	
  resource_group_name	= azurerm_resource_group.rg_fortigate.name	
  size = var.fgt_vmsize	
  admin_username = var.USERNAME	
  admin_password = var.PASSWORD	
  disable_password_authentication = false
  computer_name	= local.computer_name_s	
  custom_data	= base64encode("${templatefile("fortigate.tftpl", local.fgt_s_custom_data)}")	
  availability_set_id = azurerm_availability_set.fgtavset[0].id	
  network_interface_ids = [
    azurerm_network_interface.fgtsifcext.id, 
    azurerm_network_interface.fgtsifcint.id, 
    azurerm_network_interface.fgtsifchasync.id, 
    azurerm_network[interface.fgtsifcmgmt.id
  ]
  identity {
    type ="SystemAssigned"
  }
  source_image_reference {
    publisher = var.FGT_PUBLISHER
    offer = var.FGT_PRODUCT	
    sku = var.FGT_IMAGE_SKU	
    version = var.FGT_VERSION
 }
  os_disk {
  name = "OSDISK-SFYMAESNP${upper(var,REGION)}${var.SUFFIX}F1-$(var.SUFFIX}"	
  caching = "ReadWrite"	
  storage_account_type = "StandardSSD_LRS"
  disk_size_gb = "4"
  }

  boot_diagnostics {
  storage_account_uri = null
  }

  lifecycle {
   ignore_changes = [custom_data]
  }
  