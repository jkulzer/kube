# creates the kv mount
resource "vault_mount" "kv" {
  path        = "kv"
  type        = "kv"
  options     = { version = "2" }
}

# creates the kubernetes auth method
resource "vault_auth_backend" "kubernetes" {
  type = "kubernetes"
}

# configures the kubernetes auth method to actually work
resource "vault_kubernetes_auth_backend_config" "kubernetes-auth-config" {
  backend                = vault_auth_backend.kubernetes.path
  kubernetes_host        = "https://kubernetes.default.svc:443"
  disable_iss_validation = "true"
}

# creates the root pki mount
resource "vault_mount" "pki" {
  path                      = "pki"
  type                      = "pki"
  default_lease_ttl_seconds = 3600
  max_lease_ttl_seconds     = 630720000
}

# root certificate
resource "vault_pki_secret_backend_root_cert" "root_ca" {
  depends_on            = [vault_mount.pki]
  backend               = vault_mount.pki.path
  type                  = "internal"
  common_name           = "Kube Root CA X1"
  ttl                   = "630720000"
  key_type              = "ec"
  key_bits              = 384
  ou                    = "KubeCluster"
  organization          = "KubeCluster Root CA Admins"
}


# role for generating certificates for ingress of kube cluster
resource "vault_pki_secret_backend_role" "intermediate-cert" {
  depends_on       = [vault_mount.pki]
  backend          = "pki"
  name             = "intermediate-cert"
  ttl              = 315576000
  max_ttl              = 315576000
  key_type         = "ec"
  key_bits         = 256
  allow_any_name = true
  ou               =  ["KubeCluster"]
  organization     =  ["KubeCluster CA Users"]
  country          =  ["DE"]
}

# policy for generating certificates
resource "vault_policy" "intermediate-cert" {
  depends_on  = [vault_mount.pki]
  name = "intermediate-cert"

  policy = <<EOT
path "pki/*"                        { capabilities = ["read", "list"] }
path "pki/sign/intermediate-cert"    { capabilities = ["create", "update", "read", "list"] }
path "pki/issue/intermediate-cert"   { capabilities = ["create"] }
EOT
}

# kubernetes auth role that can generate certificates
resource "vault_kubernetes_auth_backend_role" "intermediate-cert" {
  depends_on                       =  [vault_policy.intermediate-cert, vault_pki_secret_backend_role.intermediate-cert]
  backend                          = "kubernetes"
  role_name                        = "intermediate-cert"
  bound_service_account_names      = ["vault-issuer"]
  bound_service_account_namespaces = ["istio-system"]
  token_policies                   = ["intermediate-cert"]
}
