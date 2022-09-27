#############
#rpc secret #
#############
resource "random_password" "drone-rpc-secret" {
  length           = 32
  special          = true
  override_special = "!%&+?"
}

###############################
#writing secret to vault      #
###############################

resource "vault_kv_secret_v2" "drone-rpc-secret" {
  mount                      = "kv"
  name                       = "kube/drone"
  data_json                  = jsonencode(
  {
    drone-rpc-secret = random_password.drone-rpc-secret.result,
  }
  )
}

######################################################
#policy and role for vault access via service account#
######################################################

resource "vault_policy" "drone" {
  name = "drone"

  policy = <<EOT
path "kv/kube/drone" { capabilities = ["read", "list"] }
path "kv/data/kube/drone" { capabilities = ["read", "list"] }
path "kv/kube/drone/*" { capabilities = ["read", "list"] }
path "kv/kube/drone/gitea-client-id" { capabilities = ["read", "list"] }
path "kv/kube/drone/gitea-client-secret" { capabilities = ["read", "list"] }
path "kv/kube/drone/drone-rpc-secret" { capabilities = ["read", "list"] }
path "kv/data/kube/drone/gitea-client-id/*" { capabilities = ["read", "list"] }
path "kv/data/kube/drone/gitea-client-secret/*" { capabilities = ["read", "list"] }
path "kv/data/kube/drone/drone-rpc-secret/*" { capabilities = ["read", "list"] }
path "kv/kube/drone/drone-rpc-secret/*" { capabilities = ["read", "list"] }
path "kv/data/kube/drone/drone-rpc-secret/*" { capabilities = ["read", "list"] }
EOT
}


resource "vault_kubernetes_auth_backend_role" "drone" {
  backend                          = "kubernetes"
  role_name                        = "drone"
  bound_service_account_names      = ["drone"]
  bound_service_account_namespaces = ["drone"]
  token_policies                   = ["drone"]
}