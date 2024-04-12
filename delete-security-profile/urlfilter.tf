#####################################################################################
#
# FortiManager Create Webfilter URL-Filter
#
#####################################################################################

resource "fortios_fmg_jsonrpc_request" "find_webfilter_urlfilters" {
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


output "webfilter_urlfilter_ids_out" {
    value =jsondecode(fortios_fmg_jsonrpc_request.find_webfilter_urlfilter.resppnse)[0].data[*].id
    }

resource "local_file" "webfilter_urlfilter_as_json" {
    content	= fortios_fmg_jsonrpc_request.find_webfilter_urlfilters.response	
    filename = "webfilter_urlfilters_out.json"
}


resource "fortios_fmg_jsonrpc_request" "delete_webfilter_urlfilters" { 
    for_each = {
      for webfilter_urlfilters in jsondecode(local_file.webfilter_urlfilters_as_json.content)[0].data[*] : webfilter_urlfilters.name => webfilter_urlfilters.id
   }
json_content = << JSON
 { 
  "method":"delete",
  "params": [
  {
  "ur1": "/pm/config/adom/${ver.adom)/obj/webfilter/urlfilter/${each.value)"
  }
  ]
 }
JSON
depends_on = [fortlos_fmg_jsonrpc_request.delete_webfilter_policies)

}