# We create a public IP address for our google compute instance to utilize
resource "google_compute_address" "static" {
  name = "vm-public-address"
  project = var.project
  region = var.region
  depends_on = [ google_compute_firewall.http-server ]
}



resource "google_compute_instance" "default" {
  name         = "virtual-machine-from-terraform"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-1804-bionic-v20211206"
    }
  }

  network_interface {
    network = "default"

    access_config {
      nat_ip = google_compute_address.static.address
    }
  }

  provisioner "remote-exec" {
    connection {
      host        = google_compute_address.static.address
      type        = "ssh"
      user        = var.user
      timeout     = "500s"
      private_key = file(var.privatekeypath)
    }
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install git -y",
      "cd ~",
      "git clone https://github.com/PoojaTomar007/operations-task.git",
      "cd ~/operations-task",
      "sh letstart.sh",
      "make tools",
      "make start",
      "make db -B"
    ]
  }

  metadata_startup_script = "apt-get update -y"

  // Apply the firewall rule to allow external IPs to access this instance
  tags = ["http-server"]

  metadata = {
    ssh-keys = "${var.user}:${file(var.publickeypath)}"
  }
}

resource "google_compute_firewall" "http-server" {
  name    = "default-allow-http-terraform"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  // Allow traffic from everywhere to instances with an http-server tag
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}

output "ip" {
  value = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
}
