###################################################################################################
# FortiManager Find Profile Group by VNet name#
###################################################################################################

resource "fortimanager_json_generic_api" "find_profile_group" {
  json_content = <<JSON
 {
"method": "get",
"params": [
  {
   "fields": [  
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
JSON
}
