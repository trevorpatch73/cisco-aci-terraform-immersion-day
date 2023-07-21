data "aci_leaf_interface_profile" "dataLeafInterfaceProfile" {
  for_each = local.InterfaceProfileSelectorMap
  name     = each.value.leaf_interface_profile
}

data "aci_leaf_access_port_policy_group" "dataLeafAccessPortInterfacePolicyGroup" {
  for_each = local.InterfaceProfileSelectorMap
  name     = each.value.interface_policy_group
}