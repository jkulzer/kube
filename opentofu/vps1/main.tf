terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "1.68.0"
    }
  }
}

provider "hcloud" {
}

