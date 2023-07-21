resource "aci_leaf_access_bundle_policy_group" "localLeafVpcInterfacePolicyGroup" {
  for_each = local.InterfaceProfileSelectorMap
  name     = each.value.interface_policy_group
  #name alis not working in 6.x GUI
  #random_uuid.localUUID[each.key].result
  name_alias  = each.value.interface_policy_group
  annotation  = "orchestrator:Terraform"
  description = each.value.description
  lag_t       = "node"

  relation_infra_rs_h_if_pol    = data.aci_fabric_if_pol.dataLinkLevelPolicy[each.key].id            # LINK LEVEL POLICY # SPEED
  relation_infra_rs_lldp_if_pol = data.aci_lldp_interface_policy.dataLldpPolicy[each.key].id         # LLDP POLICY
  relation_infra_rs_cdp_if_pol  = data.aci_cdp_interface_policy.dataCdpPolicy[each.key].id           # CDP POLICY
  relation_infra_rs_lacp_pol    = data.aci_lacp_policy.dataLacpPolicy[each.key].id                   # LACP POLICY
  relation_infra_rs_stp_if_pol  = data.aci_spanning_tree_interface_policy.dataStpPolicy[each.key].id # STP POLICY
  relation_infra_rs_l2_if_pol   = data.aci_l2_interface_policy.dataPortLocalScopePolicy[each.key].id # PORT LOCAL SCOPE POLICY
  relation_infra_rs_att_ent_p   = data.aci_attachable_access_entity_profile.datAEP[each.key].id      # ATTACHABLE ENTITY PROFILE

}

resource "aci_access_port_selector" "localLeafBondInterfacePortSelector" {
  for_each                  = local.InterfaceProfileSelectorMap
  leaf_interface_profile_dn = data.aci_leaf_interface_profile.dataLeafInterfaceProfile[each.key].id
  description               = each.value.description
  name                      = each.value.interface_selector
  #name alis not working in 6.x GUI
  #random_uuid.localUUID[each.key].result
  name_alias                     = each.value.interface_selector
  access_port_selector_type      = "range"
  annotation                     = "orchestrator:Terraform"
  relation_infra_rs_acc_base_grp = aci_leaf_access_bundle_policy_group.localLeafVpcInterfacePolicyGroup[each.key].id
}

resource "aci_access_port_block" "loaclLeafBondInterfacePortSelectorPortBlock" {
  for_each                = local.InterfaceProfileSelectorMap
  access_port_selector_dn = aci_access_port_selector.localLeafBondInterfacePortSelector[each.key].id
  name                    = random_uuid.localUUID[each.key].result
  name_alias              = each.value.interface_selector
  description             = each.value.description
  annotation              = "orchestrator:Terraform"
  from_card               = each.value.start_switch_slot
  from_port               = each.value.start_switch_port
  to_card                 = each.value.end_switch_slot
  to_port                 = each.value.end_switch_port
}