terraform {
  required_providers {

    vault = {
      source = "hashicorp/vault"

      version = "3.8.1"
    }

    authentik = {
      source = "goauthentik/authentik"

      version = "2022.8.1"
    }

  }
}


variable "vault_addr" {
type = string
}

variable "vault-root" {
type = string
}

provider "vault" {
  address = var.vault_addr
  token = var.vault-root
}
