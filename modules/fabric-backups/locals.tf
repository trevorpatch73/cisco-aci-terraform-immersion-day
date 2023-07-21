locals {
  iterations = csvdecode(file("./data/fabric-backups.csv"))

  policies = {
    for iteration in local.iterations : "${iteration.remote_target}.${iteration.remote_path}" => {
      backup_frequency_hours = iteration.backup_frequency_hours
      remote_target          = iteration.remote_target
      remote_path            = iteration.remote_path
    }
  }

}