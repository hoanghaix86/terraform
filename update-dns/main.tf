terraform {
  required_providers {
    dns = {
      source  = "hashicorp/dns"
      version = "3.4.3"
    }
  }
}

provider "dns" {
  # update {
  #   server        = "server_ip"
  #   port          = "server_port"
  #   key_name      = "key_name"
  #   key_algorithm = "key_algorithm"
  #   key_secret    = "key_secret"
  # }
}

resource "dns_a_record_set" "example" {
  zone      = "home.envs.io.vn."
  name      = "example"
  addresses = ["192.168.100.245"]
  ttl       = 1
}
