######################################################################################################################
# FortiManager Install Policy Package in FortiGate#
######################################################################################################################

/*
resource "fortios_fmg_jsonrpc_request" "policy_package" { 
  json_content = <<JSON
  {
  "method":"exec",
  "params":[
     {
       "data":{
           "adom":"${var.adom}",
           "adom_rev_name":"sfymaepnp${lower(var.REGION)}${var.SUFFIX}f1_createSecurityProfile_tf",
           "adom_rev_comments": "create security profile group for Spoke VNet ${var.vpc.id) and policy_id ${fortios_fmg_firewall_security_policy.firewall_policy.id}",
           "pkg":"sfymaepnp${lower(var.REGION)}${var.SUFFIX}f1",
           "flags":[
             "generate_rev"
           ] 
    },
    "ur1": “/securityconsole/install/package"
    }
  ]
  }
JSON

depends_on= [fortios_fmg_firewall_security_policy.firewall_policy]
}
# TODO change above package name and adom_rev_name with AWS names!!
*/