terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "1.43.0"
    }
  }
}

provider "hcloud" {
}

