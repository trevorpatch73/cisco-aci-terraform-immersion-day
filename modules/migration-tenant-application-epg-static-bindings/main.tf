resource "aci_epg_to_static_path" "localStaticAppEpgBindingBondAccess" {
  for_each           = local.StaticAppEpgMap
  application_epg_dn = data.aci_application_epg.dataAppEpg[each.key].id
  tdn                = each.value.bond == "SINGLE" ? "topology/pod-${each.value.pod}/paths-${each.value.node}/pathep-[${each.value.interface}]" : "topology/pod-${each.value.pod}/protpaths-${each.value.node}/pathep-[${each.value.interface}]"
  annotation         = "orchestrator:Terraform"
  encap              = "vlan-${each.value.vlan}"
  instr_imedcy       = "immediate"
  mode               = each.value.mode == "ACCESS" ? "untagged" : "regular"
}