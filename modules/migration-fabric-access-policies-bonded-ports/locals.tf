locals {
  iterations = csvdecode(file("./data/migration-fabric-access-policies-bonded-ports.csv"))

  InterfaceProfileSelectorMap = {
    for iteration in local.iterations : "${iteration.LEAF_INTERFACE_PROFILE}.${iteration.INTERFACE_SELECTOR}.${iteration.START_SWITCH_SLOT}.${iteration.START_SWITCH_PORT}.${iteration.END_SWITCH_SLOT}.${iteration.END_SWITCH_PORT}" => {
      leaf_interface_profile  = iteration.LEAF_INTERFACE_PROFILE
      interface_selector      = iteration.INTERFACE_SELECTOR
      start_switch_slot       = iteration.START_SWITCH_SLOT
      start_switch_port       = iteration.START_SWITCH_PORT
      end_switch_slot         = iteration.END_SWITCH_SLOT
      end_switch_port         = iteration.END_SWITCH_PORT
      interface_policy_group  = iteration.INTERFACE_POLICY_GROUP
      description             = iteration.DESCRIPTION
      link_level_policy       = iteration.LINK_LEVEL_POLICY
      port_local_scope_policy = iteration.PORT_LOCAL_SCOPE_POLICY
      lacp_policy             = iteration.LACP_POLICY
      lldp_policy             = iteration.LLDP_POLICY
      cdp_policy              = iteration.CDP_POLICY
      stp_policy               = iteration.STP_POLICY
      aep                     = iteration.ATTACHABLE_ENTITY_PROFILE
    }
  }
}