#################################################################################################
#FortiManager Install Policy Package in FortiGate
#################################################################################################

resource "fortios_fmg_jsonrpc_request" "policy_package" {
   json_content = <<JSON
   {
    "method": "exec",
    "params": [
      {
        "data": {
        "adom": "${var.adom}",
        "adom_rev_name": "sfymaepnp${lower(var.REGION)}$(var.SUFFIX)f1_deleteSecurityProfile_tf",
        "adom_rev_comments": "delete security profile group for Spoke VNet $(var.vnet_name)",
        "pkg": "sfymaepnp$(lower(var.REGION)}$(var.SUFFIX}f1",
        "flogs": [
          "generate_rev"
        ]
        },
      "url": "/securityconsole/install/package"
      }
    ]
   }
JSON
depends_on = [
    fortios_fmg_jsonrpc_request,delete_firewall_policies
    ]
  }