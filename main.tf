module "tenant-configurations-workflow" {
  source = "./modules/tenant-configurations"
}

module "fabric-backups-workflow" {
  source = "./modules/fabric-backups"

  sftp_username = var.CISCO_ACI_TERRAFORM_USERNAME
  sftp_password = var.CISCO_ACI_TERRAFORM_PASSWORD
}

/*
module "migration-fabric-access-policies-nonbonded-ports" {
  source = "./modules/migration-fabric-access-policies-nonbonded-ports"
}

module "migration-fabric-access-policies-bonded-ports" {
  source = "./modules/migration-fabric-access-policies-bonded-ports"
}

module "migration-tenant-application-epg-static-bindings" {
  source = "./modules/migration-tenant-application-epg-static-bindings"
}
*/