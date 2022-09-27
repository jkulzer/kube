resource "keycloak_realm" "kube-realm" {
  realm   = "kube"
  enabled = true
}

provider "keycloak" {
    client_id     = "admin-cli"
    username      = "admin"
    password      = "changeme"
    url           = "https://keycloak.kube.home"
    base_path     = ""
}

data "vault_generic_secret" "oidc-secret" {
  path = "kv/kube/keycloak-oidc"
}

resource "keycloak_openid_client" "openid_client" {
  realm_id            = keycloak_realm.kube-realm.id
  client_id           = "kube-oidc"
  client_secret       = data.vault_generic_secret.oidc-secret.data["client-secret"]
  name                = "kube-oidc"
  enabled             = true
  standard_flow_enabled   = true

  access_type         = "CONFIDENTIAL"
  valid_redirect_uris = [
    "https://oauth.kube.home/*",
    "https://grafana.kube.home/*",
    "https://vault.kube.home/*",
    "https://argocd.kube.home/*",
    "http://localhost:8250/*",
    "https://vault.kube.home/ui/vault/auth/oidc/oidc/callback"

  ]
}

#has admin permissions
resource "keycloak_group" "grafana-admin" {
  realm_id = keycloak_realm.kube-realm.id
  name     = "grafana-admin"
}

#has edit permissions
resource "keycloak_group" "grafana-dev" {
  realm_id = keycloak_realm.kube-realm.id
  name     = "grafana-dev"
}

resource "vault_jwt_auth_backend" "vault-oidc" {
    description         = "Keycloak OAuth"
    path                = "oidc"
    type                = "oidc"
    oidc_discovery_url  = "https://keycloak.kube.home/realms/kube"
    oidc_client_id      = "kube-oidc"
    oidc_client_secret  = data.vault_generic_secret.oidc-secret.data["client-secret"]
    tune {
        listing_visibility = "unauth"
    }
}

resource "vault_policy" "admin-user" {
  name = "admin-user"

  policy = <<EOT
path "internal-certs/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "kv/kube/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "pki/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "internal-certs" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "kv/kube" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "pki" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
EOT
}

resource "vault_jwt_auth_backend_role" "admin" {
  backend         = vault_jwt_auth_backend.vault-oidc.path
  role_name       = "admin"
  token_policies  = ["default", "admin-user"]
  user_claim      = "email"
  allowed_redirect_uris = ["https://vault.kube.home/ui/vault/auth/oidc/oidc/callback", "http://localhost:8200/oidc/callback"]
  verbose_oidc_logging  = "true"
}