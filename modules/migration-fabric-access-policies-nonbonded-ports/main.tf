resource "aci_access_port_selector" "localLeafNonbondInterfacePortSelector" {
  for_each                  = local.InterfaceProfileSelectorMap
  leaf_interface_profile_dn = data.aci_leaf_interface_profile.dataLeafInterfaceProfile[each.key].id
  description               = each.value.description
  name                      = each.value.interface_selector
  #name alis not working in 6.x GUI
  #random_uuid.localExportPolicyUUID[each.key].result
  name_alias                     = each.value.interface_selector
  access_port_selector_type      = "range"
  annotation                     = "orchestrator:Terraform"
  relation_infra_rs_acc_base_grp = data.aci_leaf_access_port_policy_group.dataLeafAccessPortInterfacePolicyGroup[each.key].id
}

resource "aci_access_port_block" "loaclLeafNonbondInterfacePortSelectorPortBlock" {
  for_each                = local.InterfaceProfileSelectorMap
  access_port_selector_dn = aci_access_port_selector.localLeafNonbondInterfacePortSelector[each.key].id
  name                    = random_uuid.localExportPolicyUUID[each.key].result
  name_alias              = each.value.interface_selector
  description             = each.value.description
  annotation              = "orchestrator:Terraform"
  from_card               = each.value.switch_slot
  from_port               = each.value.switch_port
  to_card                 = each.value.switch_slot
  to_port                 = each.value.switch_port
}