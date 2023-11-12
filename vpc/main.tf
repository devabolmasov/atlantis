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

resource "google_compute_network" "vpc_network" {
  name                    = "atlantis-test-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "terraform_subnetwork" {
  name          = "atlantis-test-subnetwork"
  ip_cidr_range = var.subnet_cidr_block
  region        = var.region
  network       = google_compute_network.vpc_network.id

}