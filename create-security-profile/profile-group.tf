####################################################################################################
# FortiManager Create Profile Group#
####################################################################################################
/*
resource "fortios_fmg_jsonrpc_request" "profile_group" { 
  json_content = <<JSON 
  {
   "method": "add",
   "params": [
     "data": [
     {
      "name": “${var.vpc.id}",
      "webfilter-profile": [
        "${jsondecode(fortios_fmg_jsonrpc_request.webfilter_profile.response)[0].data.name}]"
      ],
      "ssl-ssh-profile": [
        "BMW-certificate-inspection"
        ],
       "ips-sensor": [
         "BMW-IPS-high-and-fritical"
          ]
      }
        ],
      "ur1":"/pm/config/adom/${var.adom}/obj/firewa11/profile-group"
      }
      ]
      }
JSON
depends_on = [fortios_fmg_jsonrpc_request.webfilter_profile]
}
*/
