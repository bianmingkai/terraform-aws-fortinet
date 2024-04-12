#####################################################################################################
#
#  FortiManager Install Policy Package in FortiGate
#
#####################################################################################################

resource "fortimanager_json_generic_api" "policy_package" {
 json_content = <<JSON
   {
     "method":"exec",
     "params": [
     {
      "data": { 
      "adom": "${var.adom}",
      "adom_rev_name": "sfymaepnp${var.firewall)f1_deleteFirewallPolicy_tf",
      "adom_rev_comments": "delete firewall policy for Spoke VNet ${var.vnet_name}",
      "pkg":"sfymaepnp${var.firewall}f1",
      "flags": [
        "generate_rev"
      ]
      },
     "url": "/securityconsole/install/package"
    }
  ]
}
JSON

depends_on = [
  fortimanager_json_generic_api.delete_firewall_policies
 ]
}
