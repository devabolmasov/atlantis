terraform {
 backend "gcs" {
   bucket  = "itoutposts"
   prefix  = "terraform/state/atlantis_test_vpc"
 }
}

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_compute_network" "atlantis_demo_network" {
  name                    = var.vpc_network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "atlantis_demo_subnetwork" {
  name          = var.vpc_subnetwork_name
  ip_cidr_range = var.subnet_cidr_block
  region        = var.region
  network       = google_compute_network.atlantis_demo_network.id

}


resource "google_compute_firewall" "atlantis_test_firewall" {
  name    = "atlantis-demo-firewall"
  network = google_compute_network.atlantis_demo_network.self_link

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
  
  source_ranges = ["0.0.0.0/0"] # Allow HTTP access from any IP address (for demonstration purposes, you may want to restrict this to a specific IP range)
}
