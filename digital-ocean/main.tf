terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = ">= 2.8.0"
    }
  }
}

provider "digitalocean" {
  # You need to set this in your .bashrc
  # export DIGITALOCEAN_TOKEN="Your API TOKEN"
  #
  token = var.do_token
}

data "digitalocean_ssh_key" "default" {
  name = var.public_key
}

data "digitalocean_project" "first-project" {
  name = "first-project"
}

resource "digitalocean_droplet" "tftraining" {
  name   = "terraform-deploy"
  size   = "s-1vcpu-1gb"
  image  = "ubuntu-22-04-x64"
  region = "nyc1"
  ssh_keys = [data.digitalocean_ssh_key.default.fingerprint]
  user_data = <<EOF
  apt-get update -y
  apt-get install -y htop
  EOF
}


resource "digitalocean_project_resources" "project_assignment" {
  project = data.digitalocean_project.first-project.id
  resources = [
    digitalocean_droplet.tftraining.urn # Reference the Droplet's URN
  ]
}