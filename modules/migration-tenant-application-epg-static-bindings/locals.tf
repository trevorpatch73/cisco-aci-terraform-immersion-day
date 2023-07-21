locals {
  iterations = csvdecode(file("./data/migration-tenant-static-application-epg-static-bindings.csv"))

  StaticAppEpgMap = {
    for iteration in local.iterations : "${iteration.POD_NUMBER}.${iteration.NODE_NUMBER}.${iteration.INTERFACE}.${iteration.MODE}.${iteration.TENANT}.${iteration.VLAN}" => {
      pod         = iteration.POD_NUMBER
      node        = iteration.NODE_NUMBER
      bond        = iteration.BOND
      interface   = iteration.INTERFACE
      mode        = iteration.MODE
      tenant      = iteration.TENANT
      app_profile = iteration.APP_PROFILE
      app_epg     = iteration.APP_EPG
      vlan        = iteration.VLAN
    }
  }
}