provider "proxmox" {
  pm_api_url          = var.proxmox_api_url
  pm_api_token_id     = var.proxmox_api_token_id
  pm_api_token_secret = var.proxmox_api_token_secrect
  pm_tls_insecure     = true
}

resource "proxmox_vm_qemu" "dns_server" {
  vmid        = 200
  name        = "dns-server"
  target_node = "proxmox"

  clone      = "ubuntu-server-noble-docker"
  full_clone = false
  agent      = 1
  scsihw     = "virtio-scsi-single"

  vm_state = "running"
  onboot   = true
  # boot     = "c"
  startup  = "order=1,up=10"

  os_type    = "cloud-init"
  ipconfig0  = "ip=192.168.100.2/24,gw=192.168.100.1"
  nameserver = "1.1.1.1"
  ciuser     = "runner"
  sshkeys    = file("~/.ssh/id_ed25519_vm.pub")

  serial {
    id   = 0
    type = "socket"
  }

  cpu {
    sockets = 1
    cores   = 4
    type    = "host"
  }
  memory = 4096

  network {
    id       = 0
    model    = "virtio"
    bridge   = "vmbr0"
    firewall = false
  }

  disks {
    scsi {
      scsi0 {
        disk {
          storage   = "local-lvm"
          size      = "32G"
          iothread  = true
          replicate = false
        }
      }
    }
    ide {
      ide0 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
  }

  # cicustom = "vendor=local:snippets/qemu-guest-agent.yml"

  # define_connection_info = true
  # ssh_user               = "runner"
  # ssh_private_key        = file("~/.ssh/id_ed25519_vm")

  # connection {
  #   type        = "ssh"
  #   user        = self.ssh_user
  #   private_key = self.ssh_private_key
  #   host        = self.ssh_host
  #   port        = self.ssh_port
  # }

  # provisioner "remote-exec" {
  #   inline = [
  #     "while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 3; done",
  #     "sudo apt update",
  #     "sudo apt install ca-certificates curl gnupg lsb-release -y",
  #     "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg",
  #     "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
  #     "sudo apt update",
  #     "sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y",
  #     "sudo usermod -aG docker runner",
  #     "newgrp docker"
  #   ]
  # }
}
