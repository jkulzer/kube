terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "1.70.0"
    }
  }
}

provider "hcloud" {
}

