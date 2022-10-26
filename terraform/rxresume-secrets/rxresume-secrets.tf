############
#jwt secret#
############
resource "random_password" "jwt-secret" {
  length           = 32
  special          = true
  override_special = "!%&+?"
}

############
#secret key#
############
resource "random_password" "secret-key" {
  length           = 50
  special          = true
  override_special = "!%&+?"
}

###################
#postgres password#
###################
resource "random_password" "postgres-password" {
  length           = 32
  special          = true
  override_special = "!%&+?"
}

###############################
#writing secret to vault      #
###############################

resource "vault_kv_secret_v2" "rxresume-secrets" {
  mount                      = "kv"
  name                       = "kube/rxresume"
  data_json                  = jsonencode(
  {
    jwt-secret = random_password.jwt-secret.result,
    secret-key = random_password.secret-key.result,
    postgres-password = random_password.postgres-password.result,
  }
  )
}

######################################################
#policy and role for vault access via service account#
######################################################

resource "vault_policy" "rxresume" {
  name = "rxresume"

  policy = <<EOT
path "kv/kube/rxresume" { capabilities = ["read", "list"] }
path "kv/data/kube/rxresume" { capabilities = ["read", "list"] }
path "kv/kube/rxresume/*" { capabilities = ["read", "list"] }
path "kv/kube/rxresume/jwt-secret" { capabilities = ["read", "list"] }
path "kv/kube/rxresume/secret-key" { capabilities = ["read", "list"] }
path "kv/kube/rxresume/postgres-password" { capabilities = ["read", "list"] }
path "kv/data/kube/rxresume/jwt-secret/*" { capabilities = ["read", "list"] }
path "kv/data/kube/rxresume/secret-key/*" { capabilities = ["read", "list"] }
path "kv/data/kube/rxresume/postgres-password/*" { capabilities = ["read", "list"] }
path "kv/kube/rxresume/postgres-password/*" { capabilities = ["read", "list"] }
path "kv/data/kube/rxresume/postgres-password/*" { capabilities = ["read", "list"] }
EOT
}


resource "vault_kubernetes_auth_backend_role" "rxresume" {
  backend                          = "kubernetes"
  role_name                        = "rxresume"
  bound_service_account_names      = ["rxresume"]
  bound_service_account_namespaces = ["rxresume"]
  token_policies                   = ["rxresume"]
}