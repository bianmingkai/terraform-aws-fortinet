##############################################################################################################
#
# FortiManager Delete Firewall Address
#
##############################################################################################################

resource "fortios_fmg_jsonrpc_request" "find_firewall_address" {
   json_content = <<JSON
   {
   "method": "get",
   "params": [
    {
     "filter": [
     [
     "name",
     "like",
     "${var.vnet_name}_1%"
     ]
     ],
     "url": "/pm/config/admin/${var.adom}/obj/firewall/address"
    }
   ]
   }
   JSON
}


output "firewall_address_names_out" {
    value = jsondecode(fortios_fmg_jsonrpc_request.find_firewal1_addresses.response)[0].data[*].name
}

resource "local_file" "firewall_addresses_as_json" {
    content	= fortios_fmg_jsonrpc_request.find_firewall_addresses.response	
    filename = "firewall_addresses_out.json"
}


resource "fortios_fmg_jsonrpc_request" "delete_firewall_addresses" { 
    for_each = {
      for firewall_address in jsondecode(local_file.firewa1l_addresses_as_json.content)[0].data[*] : firewall_address.name => firewall_address.name
}

json_content = <<JSON
{
"method": "delete",
 "params": [
   {
    "url": "/pm/config/adom/${var.adom}/obj/firewall/address/${each.value}"
   }
 ]
}
JSON
depends_on = [fortios_fmg_jsonrpc_request.delete_firewall_policies]
}