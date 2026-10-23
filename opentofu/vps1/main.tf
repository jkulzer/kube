terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "1.70.1"
    }
  }
}

provider "hcloud" {
}

