resource "aci_trigger_scheduler" "localTriggerScheduler" {
  for_each    = local.policies
  name        = random_uuid.localExportPolicyUUID[each.key].result
  name_alias  = replace(replace(join("_", [each.key, "TRG_SCD"]), ".", "_"), "/", "_") # CISCO ACI DOESNT ACCEPT SOME SPECIAL CHARACTERS
  description = replace(replace(join("_", [each.key, "TRG_SCD"]), ".", "_"), "/", "_")
  annotation  = "orchestrator:terraform"
}

resource "aci_recurring_window" "localRecurringWindow" {
  for_each     = local.policies
  scheduler_dn = aci_trigger_scheduler.localTriggerScheduler[each.key].id
  # RANDOM_UUID SWAPPED FOR RANDOM_ID DUE TO CISCO ACI MO LENGTH REQUIREMENTS
  name              = random_id.localExportPolicyID[each.key].hex
  concur_cap        = "unlimited"
  hour              = each.value.backup_frequency_hours
  node_upg_interval = "0"
  proc_break        = "none"
  proc_cap          = "unlimited"
  time_cap          = "unlimited"
  annotation        = "orchestrator:terraform"
}

resource "aci_file_remote_path" "localFileRemotePath" {
  for_each    = local.policies
  name        = random_uuid.localExportPolicyUUID[each.key].result
  name_alias  = replace(replace(join("_", [each.key, "RFP"]), ".", "_"), "/", "_") # CISCO ACI DOESNT ACCEPT SOME SPECIAL CHARACTERS
  description = replace(replace(join("_", [each.key, "RFP"]), ".", "_"), "/", "_")
  annotation  = "orchestrator:terraform"
  auth_type   = "usePassword"
  host        = each.value.remote_target
  protocol    = "sftp"
  remote_path = each.value.remote_path
  remote_port = "22"
  user_name   = var.sftp_username
  user_passwd = var.sftp_password
}

resource "aci_configuration_export_policy" "localConfigurationExportPolicy" {
  for_each                            = local.policies
  name                                = random_uuid.localExportPolicyUUID[each.key].result
  name_alias                          = replace(replace(join("_", [each.key, "CEP"]), ".", "_"), "/", "_") # CISCO ACI DOESNT ACCEPT SOME SPECIAL CHARACTERS
  description                         = replace(replace(join("_", [each.key, "CEP"]), ".", "_"), "/", "_")
  admin_st                            = "triggered"
  annotation                          = "orchestrator:terraform"
  format                              = "json"
  include_secure_fields               = "yes"
  snapshot                            = "yes"
  relation_config_rs_remote_path      = aci_file_remote_path.localFileRemotePath[each.key].id
  relation_config_rs_export_scheduler = aci_trigger_scheduler.localTriggerScheduler[each.key].id
}
