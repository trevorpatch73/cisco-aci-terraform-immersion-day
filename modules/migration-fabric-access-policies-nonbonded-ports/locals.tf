locals {
  iterations = csvdecode(file("./data/migration-fabric-access-policies-nonbonded-ports.csv"))

  InterfaceProfileSelectorMap = {
    for iteration in local.iterations : "${iteration.LEAF_INTERFACE_PROFILE}.${iteration.INTERFACE_SELECTOR}.${iteration.SWITCH_SLOT}.${iteration.SWITCH_PORT}" => {
      leaf_interface_profile = iteration.LEAF_INTERFACE_PROFILE
      interface_selector     = iteration.INTERFACE_SELECTOR
      switch_slot            = iteration.SWITCH_SLOT
      switch_port            = iteration.SWITCH_PORT
      interface_policy_group = iteration.INTERFACE_POLICY_GROUP
      description            = iteration.DESCRIPTION
    }
  }

}