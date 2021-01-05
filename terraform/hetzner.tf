
resource "hcloud_server" "prom" {
  name        = "golem-0-prom"
  image       = "ubuntu-20.04"
  server_type = var.machine_type
  location    = var.location

  ssh_keys = ["golem-provider-terraform"]

  user_data = templatefile("./setup_golem_node.sh",
    {
      RUN_PROM=true,
      PROM_IP="pushgate",
      wallet_address=var.wallet_address,
      cpu_per_hour=var.cpu_per_hour,
      HOSTNAME="golem-0-prom-${var.wallet_address}"
    }
  )
}

resource "hcloud_server" "golem" {
  count       = var.golem_nodes_count - 1 

  name        = "golem-${count.index + 1}"
  image       = "ubuntu-20.04"
  server_type = var.machine_type
  location    = var.location

  ssh_keys = ["golem-provider-terraform"]

  user_data = templatefile("./setup_golem_node.sh",
    {
      RUN_PROM = false,
      PROM_IP = hcloud_server.prom.ipv4_address,
      wallet_address=var.wallet_address,
      cpu_per_hour=var.cpu_per_hour,
      HOSTNAME="golem-${count.index + 1}-${var.wallet_address}"
    }
  )
}
