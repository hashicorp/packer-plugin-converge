packer {
  required_version = ">=1.7.0"
  required_plugins {
    docker = {
      source  = "github.com/hashicorp/docker"
      version = ">=0.0.7"
    }
  }
}

variable "module" {
  type    = string
  default = "https://raw.githubusercontent.com/asteris-llc/converge/master/samples/fileContent.hcl"
}

source "docker" "autogenerated_1" {
  discard = true
  image   = "golang:1.8.1"
}

build {
  description = "Converge Example"
  sources     = ["source.docker.autogenerated_1"]

  provisioner "shell" {
    inline = [
      "apt-get update",
      "apt-get -qq -y install sudo",
      "go get github.com/asteris-llc/converge"
    ]
  }

  provisioner "converge" {
    module       = var.module
    prevent_sudo = true
    params = {
      message = "Hello, Packer!"
    }
  }
}