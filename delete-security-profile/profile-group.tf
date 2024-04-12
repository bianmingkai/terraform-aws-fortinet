##########################################################################################
#
#  FortiManager Create Profile Group
#
##########################################################################################

resource "fortios_fmg_jsonrpc_request" "find_profile_group" {
  json_content = <<JSON
 {
  "method": "get",
  "params": [
  {
  "field": [
  "name"
  ],
  "filter": [
  [
  "name",
  "==",
  "${var.vnet_name}"
  ]
  ],
  "url": "/pm/config/adom/${var.adom}/obj/firewall/profile-group"
  }
  ]
}
JOSN
}


output "profile_group_names_out" {
    value =jsondecode(fortios_fmg_jsonrpc_request.find_profile_groups.response)[0].data[*].name
    }

resource "local_file" "profile_groups_as_json" {
    content	= fortios_fmg_jsonrpc_request.find_profile_groups.response	
    filename = "profile_groups_out.json"
}


resource "fortios_fmg_jsonrpc_request" "delete_profile_groups" { 
    for_each = {
      for profile_group in jsondecode(local_file.profile_groups_as_json.content)[0].data[*] : profile_group.name => profile_group.name
   }
json_content = << JSON
 { 
  "method":"delete",
  "params": [
  {
  "ur1": "/pm/config/adom/${ver.adom)/obj/firewall/profile-group/${each.value)"
  }
  ]
 }
JSON
depends_on = [fortlos_fmg_jsonrpc_request.delete_firewall_policies)

}