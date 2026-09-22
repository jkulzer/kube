terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "1.69.0"
    }
  }
}

provider "hcloud" {
}

