#############
#oidc secret#
#############
resource "random_password" "client-secret" {
  length           = 32
  special          = true
  override_special = "!%&+?"
}

###############
#cookie secret#
###############

resource "random_password" "cookie-secret" {
  length           = 32
  override_special = "-_"
}

###############################
#writing both secrets to vault#
###############################

resource "vault_kv_secret_v2" "oidc-secret" {
  mount                      = "kv"
  name                       = "kube/keycloak-oidc"
  data_json                  = jsonencode(
  {
    client-secret = random_password.client-secret.result,
    cookie-secret = random_password.cookie-secret.result,
  }
  )
}

######################################################
#policy and role for vault access via service account#
######################################################

resource "vault_policy" "keycloak-oidc" {
  name = "keycloak-oidc"

  policy = <<EOT
path "kv/kube/keycloak-oidc" { 
  capabilities = ["read", "list"] 
}

path "kv/data/kube/keycloak-oidc" { 
  capabilities = ["read", "list"]
}

path "kv/kube/keycloak-oidc/client-secret/*" { 
  capabilities = ["read", "list"]
}

path "kv/kube/keycloak-oidc/cookie-secret/*" { 
  capabilities = ["read", "list"]
}

path "kv/kube/keycloak-oidc/client-secret" { 
  capabilities = ["read", "list"]
}

path "kv/kube/keycloak-oidc/cookie-secret" { 
  capabilities = ["read", "list"]
}

path "kv/kube/keycloak-oidc/*" { 
  capabilities = ["read", "list"]
}  
EOT
}


resource "vault_kubernetes_auth_backend_role" "oauth2-proxy" {
  backend                          = "kubernetes"
  role_name                        = "oauth2-proxy"
  bound_service_account_names      = ["oauth2-proxy"]
  bound_service_account_namespaces = ["oauth-proxy"]
  token_policies                   = ["keycloak-oidc"]
}

resource "vault_kubernetes_auth_backend_role" "grafana" {
  backend                          = "kubernetes"
  role_name                        = "grafana"
  bound_service_account_names      = ["grafana"]
  bound_service_account_namespaces = ["grafana"]
  token_policies                   = ["keycloak-oidc"]
}