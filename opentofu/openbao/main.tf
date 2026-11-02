provider "vault" {
  address = "http://localhost:8200"
}

resource "vault_auth_backend" "kubernetes" {
  type = "kubernetes"
}

resource "vault_kubernetes_auth_backend_config" "example" {
  backend                = vault_auth_backend.kubernetes.path
  kubernetes_host        = "https://kubernetes.default.svc:443"
  disable_iss_validation = true
}

resource "vault_mount" "kvv2" {
  path        = "kvv2"
  type        = "kv"
  options     = { version = "2" }
  description = "KV Version 2 secret engine mount"
}

resource "vault_kubernetes_auth_backend_role" "mastodon" {
  backend                          = vault_auth_backend.kubernetes.path
  role_name                        = "mastodon"
  bound_service_account_names      = ["mastodon-openbao"]
  bound_service_account_namespaces = ["mastodon"]
  token_ttl                        = 3600
  token_policies                   = ["mastodon"]
}

resource "vault_policy" "mastodon" {
  name = "mastodon"
  policy = <<EOT
path "kvv2/mastodon" {
  capabilities = ["read"]
}
path "kvv2/data/mastodon" {
  capabilities = ["read"]
}
EOT
}


resource "vault_kubernetes_auth_backend_role" "authelia" {
  backend                          = vault_auth_backend.kubernetes.path
  role_name                        = "authelia"
  bound_service_account_names      = ["default"]
  bound_service_account_namespaces = ["authelia"]
  token_ttl                        = 3600
  token_policies                   = ["authelia"]
}

resource "vault_kubernetes_auth_backend_role" "default" {
  backend                          = vault_auth_backend.kubernetes.path
  role_name                        = "default"
  bound_service_account_names      = ["*"]
  bound_service_account_namespaces = ["vault-secrets-webhook"]
  token_ttl                        = 3600
  token_policies                   = ["authelia"]
}

resource "vault_kubernetes_auth_backend_role" "volsync" {
  backend                          = vault_auth_backend.kubernetes.path
  role_name                        = "volsync"
  bound_service_account_names      = ["default"]
  bound_service_account_namespaces = ["*"]
  token_ttl                        = 3600
  token_policies                   = ["volsync"]
}

resource "vault_kubernetes_auth_backend_role" "argocd" {
  backend                          = vault_auth_backend.kubernetes.path
  role_name                        = "argocd"
  bound_service_account_names      = ["default"]
  bound_service_account_namespaces = ["argocd"]
  token_ttl                        = 3600
  token_policies                   = ["argocd"]
}

resource "vault_policy" "argocd" {
  name = "argocd"
  policy = <<EOT
path "kvv2/argocd" {
  capabilities = ["read", "list"]
}
path "kvv2/data/argocd" {
  capabilities = ["read", "list"]
}
EOT
}

resource "vault_kubernetes_auth_backend_role" "immich" {
  backend                          = vault_auth_backend.kubernetes.path
  role_name                        = "immich"
  bound_service_account_names      = ["default"]
  bound_service_account_namespaces = ["immich"]
  token_ttl                        = 3600
  token_policies                   = ["immich"]
}

resource "vault_policy" "immich" {
  name = "immich"
  policy = <<EOT
path "kvv2/immich" {
  capabilities = ["read", "list"]
}
path "kvv2/data/immich" {
  capabilities = ["read", "list"]
}
EOT
}

resource "vault_policy" "volsync" {
  name = "volsync"
  policy = <<EOT
path "kvv2/volsync" {
  capabilities = ["read", "list"]
}
EOT
}

resource "vault_policy" "authelia" {
  name = "authelia"
  policy = <<EOT
path "kvv2/authelia" {
  capabilities = ["read", "list"]
}
path "kvv2/data/authelia" {
  capabilities = ["read", "list"]
}
path "kvv2/mastodon" {
  capabilities = ["read", "list"]
}
path "kvv2/data/mastodon" {
  capabilities = ["read", "list"]
}
path "kvv2/synapse" {
  capabilities = ["read", "list"]
}
path "kvv2/data/synapse" {
  capabilities = ["read", "list"]
}
path "kvv2/cnpg" {
  capabilities = ["read", "list"]
}
path "kvv2/data/cnpg" {
  capabilities = ["read", "list"]
}
path "kvv2/grafana" {
  capabilities = ["read", "list"]
}
path "kvv2/data/grafana" {
  capabilities = ["read", "list"]
}
EOT
}

