resource "fortios_fmg_jsonrpc_request" "find_firewall_policies” { 
    json_content = << JSON
    {
      "method": "get",
      "params": [
        {
        "fields":[
           "policyid",
           "obj seq",
           "name"
        ],
      "filter": [
       {
      "name", 
      "==",
      "${var.vnet_name}"
      ]
      ],
      "ur1": "/pm/config/adom/${var.adom)/pkg/sfymaepnp${lower(var.REGION))${var.SUFFIX)f1/firewall/policy"
    }
    ]
JSON

output "firewall_policy_ids_out"{
    value =jsondecode(fortios_fmg_jsonrpc_request.find_firewall_policies.response)[0],data[*].policyid

resource "local_file" "firewall_policies_as_json" {
  content	= fortios_fmg_jsonrpc_request.find_firewal1_policies.response	
  filename = "firewall_policies_out.json"

resource "fortios_fmg_jsonrpc_request" "delete_firewall_policies" { 
    for_each = {
        for firewall_policy in jsondecode(local_file.firewall_policies_as_json.content)[0].data[*] : firewall_policy.name => firewall_policy.policyid
    }
  json_content  = <<JSON
  {
    "method": "delete",
    "params": [
    {
     "url": "/pm/config/adom/${var.adom}/pkg/sfymaepnp${lower(var.REGION)${var.SUFFIX}发/firewall/policy/${each.value}"
    }
    ]
  }
  JSON
}