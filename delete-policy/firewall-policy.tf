############################################################################################################
#
# FortiManager Create Firewall Plicy in target firewall
#
############################################################################################################

resource "fortimanager_json_generic_api" "find_firewall_polices" {
  json_content =<<JSON
{
  "method": "get",
  "params": [
   {
    "fields": [
       "policyid",
       "obj seq",
       "name"
       ],
    "filter": [
     [
       "name",
       "==",
       "${var.vnet_name}"
        ]
        ],
       "url": "/pm/config/adom/${var.adom}/pkg/sfymaepnp${var.firewall)f1/firewall/policy"
     }
   ]
 }
JSON
}


output "firewall_policy_ids_out" {
    value = jsondecode(fortimanager_json_generic_api.find_firewall_policies.response).result[0].data[*].policyid
 }


resource "local_file" "firewall_policies_as_json" {file.firewall_policies_asJson.content).result[0]
    content	= fortimanager_json_generic_api.find_firewall_policies.response	
    filename = "firewall_policies_out.json"
}


resource "fortimanager_json_generic_api" "delete_firewall_policies" {
  for_each = {
     for firewall_policy in jsondecode(local_file.firewall_policies_as_json.content).result[0].data[*] ' firewall_policy.name => firewall_policy.policyid
  }
json_content = <<JSON
{
  "method": "delete"
  "params": [
    {
      "url": "/pm/config/adom/${var.adom}/pkg/sfymaepnp${var.firewall)f1/firewall/policy${each.value}"
     }
   ]
}
JSON
}
