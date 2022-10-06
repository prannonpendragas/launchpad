resource "openstack_blockstorage_volume_v2" "msr" {
  count = var.msr_count
  name = "${var.cluster_name}-msr-volume-${count.index}"
  size = var.msr_volume_size
}

resource "openstack_compute_volume_attach_v2" "msr" {
  count       = var.msr_count
  instance_id = element(openstack_compute_instance_v2.docker-msr.*.id, count.index)
  volume_id   = element(openstack_blockstorage_volume_v2.msr.*.id, count.index)
}
