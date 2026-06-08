terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "1.65.0"
    }
  }
}

provider "hcloud" {
}

