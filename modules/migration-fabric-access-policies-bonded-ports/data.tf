data "aci_leaf_interface_profile" "dataLeafInterfaceProfile" {
  for_each = local.InterfaceProfileSelectorMap
  name     = each.value.leaf_interface_profile
}

data "aci_fabric_if_pol" "dataLinkLevelPolicy" {
  for_each = local.InterfaceProfileSelectorMap
  name     = each.value.link_level_policy
}

data "aci_lldp_interface_policy" "dataLldpPolicy" {
  for_each = local.InterfaceProfileSelectorMap
  name     = each.value.lldp_policy
}

data "aci_cdp_interface_policy" "dataCdpPolicy" {
  for_each = local.InterfaceProfileSelectorMap
  name     = each.value.cdp_policy
}

data "aci_lacp_policy" "dataLacpPolicy" {
  for_each = local.InterfaceProfileSelectorMap
  name     = each.value.lacp_policy
}

data "aci_spanning_tree_interface_policy" "dataStpPolicy" {
  for_each = local.InterfaceProfileSelectorMap
  name     = each.value.stp_policy
}

data "aci_l2_interface_policy" "dataPortLocalScopePolicy" {
  for_each = local.InterfaceProfileSelectorMap
  name     = each.value.port_local_scope_policy
}

data "aci_attachable_access_entity_profile" "datAEP" {
  for_each = local.InterfaceProfileSelectorMap
  name     = each.value.aep
}