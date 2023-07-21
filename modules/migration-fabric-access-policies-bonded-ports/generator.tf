resource "random_uuid" "localUUID" {
  for_each = local.InterfaceProfileSelectorMap
}