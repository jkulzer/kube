terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "1.50.1"
    }
  }
}

provider "hcloud" {
}

