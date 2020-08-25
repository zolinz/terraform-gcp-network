output "myname" {
  value = module.network.network_name
  }


output "subnetname" {
  value = module.network.subnets_names[0]
  }
