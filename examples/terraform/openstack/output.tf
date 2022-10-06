locals {
  managers = [
    for ip in module.masters.public_ips : {
      ssh: {
        address = ip
        user    		= "${var.user}"
        keyPath 	= "${var.ssh_key_path}"
        port			 	= 22
      }
      role    = "manager"
      mcrConfig: {
        debug: true
        log-opts: {
          max-size: "10m"
          max-file: "3"
        }
      }
    }
  ]
  msrs = [
    for ip in module.msrs.public_ips : {
      ssh: {
        address = ip
        user                    = "${var.user}"
        keyPath         = "${var.ssh_key_path}"
        port                    = 22
      }
      role    = "msr"
      mcrConfig: {
        debug: true
        log-opts: {
          max-size: "10m"
          max-file: "3"
        }
      }
    }
  ]
  workers = [
    for ip in module.workers.public_ips : {
      ssh: {
        address = ip
        user    		= "${var.user}"
        keyPath 	= "${var.ssh_key_path}"
        port    		= 22
      }
      role    = "worker"
      mcrConfig: {
        debug: true
        log-opts: {
          max-size: "10m"
          max-file: "3"
        }
      }
    }
  ]
  launchpad_tmpl = {
    apiVersion = "launchpad.mirantis.com/mke/v1.3"
    kind = "mke+msr"
    metadata = {
      name = "mkecluster"
    }
    spec = {
      mke = {
        version = var.docker_enterprise_version
        imageRepo = var.docker_image_repo
        adminUsername = "admin"
        adminPassword = var.admin_password
      }
      msr = {
        version = var.docker_registry_version
        imageRepo = var.docker_image_repo
        installFlags: [
          "--ucp-insecure-tls",
          "--dtr-external-url ${module.msrs.lb_ip}",
        ]
      }
      mcr = {
        version = var.docker_engine_version
        channel = "stable"
        repoURL = "https://repos.mirantis.com"
      }
      hosts = concat(local.managers, local.msrs, local.workers)
    }
  }
}

output "mke_cluster" {
  value = yamlencode(local.launchpad_tmpl)
}
