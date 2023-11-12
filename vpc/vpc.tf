resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "terraform_subnetwork" {
  name          = var.vpc_subnetwork_name
  ip_cidr_range = var.subnet_cidr_block
  region        = var.region
  network       = google_compute_network.vpc_network.id

}