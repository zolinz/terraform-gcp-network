provider "google" {
  version = "3.5.0"

  credentials = file("terraform-key.json")

  project = "terraform-course-287320"
  region  = "australia-southeast1"
  zone    = "australia-southeast1-c"
}

module "network" {
  source = "./my-modules"
}

resource "google_compute_address" "static_ip" {
  name = "terraform-static-ip"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = module.network.myname
    subnetwork = module.network.subnetname
    access_config {
      nat_ip = google_compute_address.static_ip.address
    }
    
  }
}


terraform {
  backend "gcs" {
    bucket = "terraform-course-zoli"
    prefix = "terraform01"
    credentials = "terraform-key.json"
   }
}
