#################################
#  PREPARE THE DEPLOYMENT
#################################

resource "libvirt_pool" "devops" {
  name          = "devops"
  type          = "dir"
  path          = "/tmp/devops"
}
resource "libvirt_volume" "os_image" {
  name          = var.base_image_name
  source        = var.base_image_url
  pool          = libvirt_pool.devops.name
}

data "template_file" "user_data" {
  template      = file("${path.module}/../files/cloud_init.cfg")
}

data "template_file" "network_config" {
  template      = file("${path.module}/../files/network_config.cfg")
}

resource "libvirt_cloudinit_disk" "commoninit" {
  name          = "commoninit.iso"
  user_data     = data.template_file.user_data.rendered
  network_config= data.template_file.network_config.rendered
  pool          = libvirt_pool.devops.name
}

#################################
# CREATE THE MACHINES AND VOLUMES
#################################

resource "libvirt_volume" "demo_terraform" {
  count         = lookup(var.demo_terraform_vm, "count")
  name          = "demo_terraform_${count.index}"
  pool          = libvirt_pool.devops.name
  size          = lookup(var.demo_terraform_vm, "disk")
  base_volume_id= libvirt_volume.os_image.id
}

resource "libvirt_domain" "demo_terraform" {
  count         = lookup(var.demo_terraform_vm, "count")
  name          = "demo_terraform_${count.index}"
  memory        = lookup(var.demo_terraform_vm, "memory")
  vcpu          = lookup(var.demo_terraform_vm, "vcpu")
  cloudinit     = libvirt_cloudinit_disk.commoninit.id
  network_interface {
    hostname    = "demo_terraform_${count.index}"
  }
  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }
  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }
  disk {
    volume_id   = element(libvirt_volume.demo_terraform.*.id, count.index)
  }
  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
  xml {
    xslt =<<EOF
<?xml version="1.0" ?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output omit-xml-declaration="yes" indent="yes"/>
    <xsl:template match="node()|@*">
        <xsl:copy>
        <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="*[text() = '/dev/urandom']/text()">
        <xsl:value-of select="'/dev/random'"/>
    </xsl:template>

</xsl:stylesheet>
EOF
  }
}
