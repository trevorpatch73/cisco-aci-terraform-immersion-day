resource "random_uuid" "localExportPolicyUUID" {
  for_each = local.InterfaceProfileSelectorMap
}