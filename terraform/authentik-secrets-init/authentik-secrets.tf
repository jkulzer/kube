###############
#main   secret#
###############

resource "random_password" "main-secret" {
  length           = 50
  override_special = "-_"
}

#################
#postgres secret#
#################

resource "random_password" "postgresadmin" {
  length           = 50
  override_special = "-_"
}

###############
#redis  secret#
###############

resource "random_password" "redispass" {
  length           = 50
  override_special = "-_"
}

########################
#initial admin password#
########################

resource "random_password" "initial-admin-password" {
  length           = 50
  override_special = "-_"
}

###############################
#writing all  secrets to vault#
###############################

resource "vault_kv_secret_v2" "authentik-secrets" {
  mount                      = "kv"
  name                       = "kube/authentik"
  data_json                  = jsonencode(
  {
    secret = random_password.main-secret.result
    postgresadmin = random_password.postgresadmin.result
    redispass = random_password.redispass.result
    initialadminpassword = random_password.initial-admin-password.result
  }
  )
}

######################################################
#policy and role for vault access via service account#
######################################################

resource "vault_policy" "authentik" {
  name = "authentik"

  policy = <<EOT
path "kv/kube/authentik" { 
  capabilities = ["read", "list"] 
}

path "kv/data/kube/authentik" { 
  capabilities = ["read", "list"]
}

path "kv/kube/authentik/*" { 
  capabilities = ["read", "list"]
}  
EOT
}


resource "vault_kubernetes_auth_backend_role" "authentik" {
  backend                          = "kubernetes"
  role_name                        = "authentik"
  bound_service_account_names      = ["authentik"]
  bound_service_account_namespaces = ["authentik"]
  token_policies                   = ["authentik"]
}