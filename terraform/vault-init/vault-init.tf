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