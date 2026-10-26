terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "1.70.2"
    }
  }
}

provider "hcloud" {
}

