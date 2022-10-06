terraform {
  required_version        = ">= 0.14.0"
  required_providers {
    openstack = {
      source              = "terraform-provider-openstack/openstack"
      version             = "~> 1.35.0"
    }
  }
}

provider "openstack" {
  use_octavia = "true"
  region = var.region
  insecure = "true"
}


resource "openstack_compute_keypair_v2" "key-pair" {
  name                   = "launchpad-key"
  public_key             = file("${var.ssh_key_path}.pub")
}

module "network" {
  source                 = "./modules/network"
  cluster_name           = var.cluster_name
  external_network_id    = var.external_network_id
  dns_ips                = var.dns_ip_list
}

module "masters" {
  source                = "./modules/masters"
  master_count          = var.master_count
  cluster_name          = var.cluster_name
  ssh_key               = "launchpad-key"
  master_image_name     = var.master_image_name
  master_flavor         = var.master_flavor
  external_network_name = var.external_network_name
  internal_network_name = module.network.network_name
  internal_subnet_id    = module.network.subnet_id
  base_sec_group_id     = module.network.base_security_group_id
}

module "msrs" {
  source                = "./modules/msrs"
  msr_count             = var.msr_count
  cluster_name          = var.cluster_name
  ssh_key               = "launchpad-key"
  msr_image_name        = var.msr_image_name
  msr_flavor            = var.msr_flavor
  external_network_name = var.external_network_name
  internal_network_name = module.network.network_name
  internal_subnet_id    = module.network.subnet_id
  base_sec_group_id     = module.network.base_security_group_id
}

module "workers" {
  source                = "./modules/workers"
  worker_count          = var.worker_count
  cluster_name          = var.cluster_name
  ssh_key               = "launchpad-key"
  worker_image_name     = var.worker_image_name
  worker_flavor         = var.worker_flavor
  external_network_name = var.external_network_name
  internal_network_name = module.network.network_name
  internal_subnet_id    = module.network.subnet_id
  base_sec_group_id     = module.network.base_security_group_id
}

