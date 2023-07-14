terraform {
  required_providers {

    vault = {
      source = "hashicorp/vault"

      version = "3.18.0"
    }

    authentik = {
      source = "goauthentik/authentik"

      version = "2023.6.0"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.22.0"
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
