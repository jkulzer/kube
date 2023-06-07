######################################################
#policy and role for vault access via service account#
######################################################

resource "vault_policy" "alertmanager" {
  name = "alertmanager-discord"

  policy = <<EOT
path "kv/kube/alertmanager" { 
  capabilities = ["read", "list"] 
}

path "kv/data/kube/alertmanager" { 
  capabilities = ["read", "list"]
}

path "kv/kube/alertmanager/*" { 
  capabilities = ["read", "list"]
}  
EOT
}


resource "vault_kubernetes_auth_backend_role" "alertmanager" {
  backend                          = "kubernetes"
  role_name                        = "alertmanager-discord"
  bound_service_account_names      = ["alertmanager-discord"]
  bound_service_account_namespaces = ["alertmanager-discord"]
  token_policies                   = ["alertmanager-discord"]
}