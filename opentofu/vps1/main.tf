terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "1.61.0"
    }
  }
}

provider "hcloud" {
}

