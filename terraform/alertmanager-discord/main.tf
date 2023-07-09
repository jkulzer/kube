terraform {

  required_providers {

    vault = {
      source = "hashicorp/vault"

      version = "3.17.0"
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
