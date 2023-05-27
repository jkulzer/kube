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
resource "vault_pki_secret_backend_role" "kube-home-certs" {
  depends_on       = [vault_mount.pki]
  backend          = "pki"
  name             = "kube-home-certs"
  ttl              = 2592000
  max_ttl          = 2592000
  allow_ip_sans    = true
  key_type         = "ec"
  key_bits         = 384
  allowed_domains  = ["kube.home"]
  allow_subdomains = true
  allow_bare_domains  = true
  ou               =  ["KubeCluster"]
  organization     =  ["KubeCluster CA Users"]
  country          =  ["DE"]
}

# policy for generating certificates
resource "vault_policy" "kube-home-certs" {
  depends_on  = [vault_mount.pki]
  name = "kube-home-certs"

  policy = <<EOT
path "pki/*"                        { capabilities = ["read", "list"] }
path "pki/sign/kube-home-certs"    { capabilities = ["create", "update", "read", "list"] }
path "pki/issue/kube-home-certs"   { capabilities = ["create"] }
EOT
}

# kubernetes auth role that can generate certificates
resource "vault_kubernetes_auth_backend_role" "home-home-certs" {
  depends_on                       =  [vault_policy.kube-home-certs, vault_pki_secret_backend_role.kube-home-certs ]
  backend                          = "kubernetes"
  role_name                        = "kube-home-certs"
  bound_service_account_names      = ["vault-issuer"]
  bound_service_account_namespaces = ["istio-system"]
  token_policies                   = ["kube-home-certs"]
}