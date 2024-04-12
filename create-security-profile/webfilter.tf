
###########################################################################################################
#FortiManager Create Webfilter Profile
###########################################################################################################

/*
resource "fortios_fmg_jsonrpc_request" "webfilter_profile" { 
   json_content =<<JSON
{
  "method": "add",
  "params": [
   {
  "data": [
   {
    "name": "${var.vnet_name}",
    "web": {
      "urlfilter-table": [
        "${jsondecode(fortios_fmg_jsonrpc_request.webfilter_urlfilter.response)[0].data.id}"
         ]
      }
   }
],
"url": "/pm/config/adom/${var.adom}/obj/webfilter/profile"

JSON
depends_on = [fortios_fmg_jsonrpc_request.webfilter_urlfilter]
}
*/
