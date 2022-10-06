variable "cluster_name" {
  default = "mke"
}

variable "docker_enterprise_version" {
  type = string
  default = "3.5.5"
}

variable "docker_engine_version" {
  type = string
  default = "20.10.7"
}

variable "docker_registry_version" {
  type = string
  default = "2.9.9"
}

variable "docker_image_repo" {
  type = string
  default = "docker.io/docker"
}

variable "provider_config_file_path" {
  type = string
}

variable "http_proxy" {
  type = string
  default = ""
}

variable "https_proxy" {
  type = string
  default = ""
}

variable dns_ip_list {
  type 		= list(string)
  default = []
}

variable "ssh_key_path" {
  default = "./ssh_keys/my_rsa"
}

variable "user" {
  default = "ubuntu"
}
variable "external_network_name" {}
variable "external_network_id" {}

variable "region" {
  default = "RegionOne"
}

variable "admin_password" {
  default = "mke-ftw!!!"
}

variable "master_count" {
  default = 1
}

variable "msr_count" {
  default = 1
}

variable "worker_count" {
  default = 3
}

variable "master_image_name" {
  default = "ubuntu18.04"
}

variable "msr_image_name" {
  default = "ubuntu18.04"
}

variable "worker_image_name" {
  default = "ubuntu18.04"
}

variable "master_flavor" {
  default = "m5.large"
}

variable "msr_flavor" {
  default = "m5.large"
}

variable "worker_flavor" {
  default = "m5.large"
}

variable "master_volume_size" {
  default = 100
}

variable "worker_volume_size" {
  default = 100
}
