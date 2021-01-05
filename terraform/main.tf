variable "hcloud_token" {}
variable "machine_type" {}
variable "location" {}
variable "wallet_address" {}
variable "cpu_per_hour" {
    type        = number
}

variable golem_nodes_count {
  description = "Number of Golem Nodes (min 1)"
  type        = number
}

terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.20.1"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}


output "prom_ip_address" {
  value = hcloud_server.prom.ipv4_address
}

output "node_ip_address" {
  value = hcloud_server.golem.*.ipv4_address
}