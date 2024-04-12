#####################################################################################
#
# FortiManager Delete Webfilter Profile
#
#####################################################################################

resource "fortios_fmg_jsonrpc_request" "find_webfilter_profiles" {
  json_content = <<JSON
 {
  "method": "get",
  "params": [
  {
  "filter": [
  [
  "name",
  "==",
  "${var.vnet_name}"
  ]
  ],
  "url": "/pm/config/adom/${var.adom}/obj/webfilter/profile"
  }
  ]
}
JOSN
}


output "webfilter_profile_names_out" {
  value = jsondecode(fortios_fmg_jsonrpc_request.find_webfilter_profiles.response)[0].data[*].name
  }

resource "local_file" "webfilter_profiles_as_json" {
    content	= fortios_fmg_jsonrpc_request.find_webfilter_profiles.response	
    filename = "webfilter_profiles_out.json"
    }
resource "fortios_fmg_jsonrpc_request" "delete_webfilter_profiles" {
   for_each = {
      for webfilter_profile in jsondecode(local_file.webfilter_profiles_as_json.content)[0].data[*] : webfilter_profile.name => webfilter_profile.name
      }
  json_content = << JSON
  {
    "method":"delete",
    "params": [
     {
      "url": "/pm/config/adom/${var.adom}/obj/webfilter/profile/${each.value}"
      }
    ]
  }
JSON
depends_on = [fortios_fmg_jsonrpc_request.delete_profile_groups]

}
