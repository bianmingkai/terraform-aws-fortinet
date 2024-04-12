###############################################################################################################

# FortiManager Create Firewall Address
#
###############################################################################################################

#DATA vpc shared firewall
#Example VPC-https://registry.terraform.io/providers/hashicorp/awaDlatest/docs/data-sources/vpc 
data "aws_vpc" "spoke_vpc_ip_ranges" {
  id = var.vpc.id
  }

output "spoke_vpc_ip_ranges"{
  value = data.aws_vpc.spoke_vpc_ip_ranges.cidr_block

}

resource "fortios_fmg_firewall_oject_address" "firewall_addresses" {

  for_each {
    for address_space in tolist([data.aws_vpc.spokevpc_ip_ranges.cidr_block]) : address_space => address_space
    #TODO get VPC address range
  }
  name = "${var.vpc.id}_${replace(each.value, "/", "_")}"
  type = "ipmask"
  subnet = "${cidrhost(each.value, 0)} ${cidrnetmask(each.value)}"
  adom = var.vdom
}