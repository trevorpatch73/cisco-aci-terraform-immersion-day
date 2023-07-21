resource "random_uuid" "localExportPolicyUUID" {
  for_each = local.policies
}
resource "random_id" "localExportPolicyID" {
  for_each    = local.policies
  byte_length = 8
}