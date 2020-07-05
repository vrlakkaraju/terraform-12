data "template_file" "init-script"{
  template = "file(scripts/init.cfg)"
  vars = {
    REGION = "var.AWS_REGION"
  }
}

data "template_file" "vol-script"{
  template = "file(scripts/vol-config.sh)"
  vars = {
    DEVICE = "var.DEVICE_NAME"
  }
}

data "template_cloudinit_config" "cloudinit-example"{
  gzip = "false"
  base64_encode = "false"

  part {
    filename = "init.cfg"
    content_type = "text/cloud-config"
    content = "data.template_file.init-script.rendered"
  }

  part {
    filename = "vol-config.sh"
    content_type = "text/x-shellscript"
    content = "data.template_file.vol-script.rendered"
  }
}
