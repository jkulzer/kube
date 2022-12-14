# creates the kv mount
resource "vault_mount" "kv" {
  path        = "kv"
  type        = "kv"
  options     = { version = "2" }
}

# creates the root pki mount
resource "vault_mount" "pki_root" {
  path                      = "root-pki"
  type                      = "pki"
  default_lease_ttl_seconds = 3600
  max_lease_ttl_seconds     = 630720000
}


resource "tls_private_key" "private_root_key" {
  // algorithm = "RSA"
  rsa_bits  = 4096
}

# 
# Create a Self Signed Certificate , to use as the Root Certificate Authority
#
resource tls_self_signed_cert ca_cert {
   private_key_pem = tls_private_key.private_root_key.private_key_pem
   key_algorithm = "RSA"
   subject {
     common_name = "Kube Root CA X1"
     organization = "Acme Inc"
     organizational_unit = "Development"
     street_address = ["1234 Main Street"]
     locality = "Beverly Hills"
     province = "CA"
     country = "USA"
     postal_code = "90210"

   }
   # 175200 = 20 years
   validity_period_hours = 175200
   allowed_uses = [
     "cert_signing",
     "crl_signing"
   ]
   is_ca_certificate = true 

}

# role for generating certificates for ingress of kube cluster
resource "vault_pki_secret_backend_role" "role" {
  backend          = "intermediate-pki"
  name             = "kube-home-certs"
  ttl              = 3600
// max_ttl          = 2592000
  allow_ip_sans    = true
  key_type         = "rsa"
  key_bits         = 4096
  allowed_domains  = ["kube.home"]
  allow_subdomains = true
  allow_bare_domains  = true
  ou               =  ["KubeCluster"]
  organization     =  ["KubeCluster Intermediate CA Users"]
  country          =  ["DE"]
}

# policy for generating certificates
resource "vault_policy" "kube-home-certs" {
  name = "kube-home-certs"

  policy = <<EOT
path "intermediate-pki/*"                        { capabilities = ["read", "list"] }
path "intermediate-pki/sign/kube-home-certs"    { capabilities = ["create", "update", "read", "list"] }
path "intermediate-pki/issue/kube-home-certs"   { capabilities = ["create"] }
EOT
}