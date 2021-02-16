provider "google" {
  credentials = file("./cred.json")
  region      = "asia-northeast1"
  zone        = "asia-northeast1-c"
  project = var.project-name
}

resource "google_compute_address" "static" {
  name = "ipv4-address"
}

resource "google_compute_instance" "minecraft-server" {
  name         = "minecraft-server"
  machine_type = "n1-standard-1"
  zone         = "asia-northeast1-c"
  tags = [ "minecraft-port" ]
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-bionic-v20210211"
    }
  }
  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }
  metadata = {
    ssh-keys = "${var.username}:${file("~/.ssh/minecraft-gcp.pub")}"
  }
}

resource "google_compute_firewall" "minecraft-port" {
  name    = "minecraft-port"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["25565"]
  }

  // Allow traffic from everywhere to instances with an http-server tag
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["minecraft-port"]
}

output "ip" {
  value = google_compute_instance.minecraft-server.network_interface.0.access_config.0.nat_ip
}