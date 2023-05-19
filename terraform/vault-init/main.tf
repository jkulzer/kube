terraform {

  required_providers {

    vault = {
      source = "hashicorp/vault"
    }

    tls = {
      source = "hashicorp/tls"
    }
  }


}


variable "vault_addr" {
type = string
}

provider "vault" {
  address = var.vault_addr
}