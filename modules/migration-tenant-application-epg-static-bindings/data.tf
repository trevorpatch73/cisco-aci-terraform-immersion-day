data "aci_tenant" "dataTenant" {
  for_each = local.StaticAppEpgMap
  name     = each.value.tenant
}

data "aci_application_profile" "dataAppProfile" {
  for_each  = local.StaticAppEpgMap
  tenant_dn = data.aci_tenant.dataTenant[each.key].id
  name      = each.value.app_profile
}

data "aci_application_epg" "dataAppEpg" {
  for_each               = local.StaticAppEpgMap
  application_profile_dn = data.aci_application_profile.dataAppProfile[each.key].id
  name                   = each.value.app_epg
}
