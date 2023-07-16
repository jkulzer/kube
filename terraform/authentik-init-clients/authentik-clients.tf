########################
#get authentik password#
########################

data "vault_generic_secret" "authentik" {
  path = "kv/kube/authentik"
}

##################
#authentik config#
##################

provider "authentik" {
  url   = "http://authentik.authentik.svc.cluster.local:80"
  token = data.vault_generic_secret.authentik.data["initialadmintoken"]
}

#########
#outpost#
#########

data "authentik_flow" "default-authorization-flow" {
  slug = "default-provider-authorization-implicit-consent"
}

resource "authentik_service_connection_kubernetes" "local" {
  name  = "local"
  local = true
}

resource "authentik_outpost" "proxy-outpost" {
  name = "Proxy Outpost"
  service_connection = authentik_service_connection_kubernetes.local.id
  protocol_providers = [
    authentik_provider_proxy.proxy-prometheus.id,
    authentik_provider_proxy.proxy-alertmanager.id,
    authentik_provider_proxy.proxy-longhorn.id,
    authentik_provider_proxy.proxy-homer.id
  ]
  # the config must be encoded in json, \" is required to escape the quotes
  config = "{\"authentik_host\": \"http://authentik.authentik.svc.cluster.local:80\",\"authentik_host_browser\": \"https://authentik.kube.home\"}"
}

############
#prometheus#
############

resource "authentik_provider_proxy" "proxy-prometheus" {
  name               = "Prometheus"
  authorization_flow = data.authentik_flow.default-authorization-flow.id
  external_host      = "https://prometheus.kube.home"
  mode               = "forward_single"
}

resource "authentik_application" "proxy-prometheus" {
  name              = "Prometheus"
  slug              = "prometheus"
  protocol_provider = authentik_provider_proxy.proxy-prometheus.id
}

##############
#alertmanager#
##############

resource "authentik_provider_proxy" "proxy-alertmanager" {
  name               = "Alertmanager"
  authorization_flow = data.authentik_flow.default-authorization-flow.id
  external_host      = "https://alertmanager.kube.home"
  mode               = "forward_single"
}

resource "authentik_application" "proxy-alertmanager" {
  name              = "Alertmanager"
  slug              = "alertmanager"
  protocol_provider = authentik_provider_proxy.proxy-alertmanager.id
}

##########
#longhorn#
##########

resource "authentik_provider_proxy" "proxy-longhorn" {
  name               = "Longhorn"
  authorization_flow = data.authentik_flow.default-authorization-flow.id
  external_host      = "https://longhorn.kube.home"
  mode               = "forward_single"
}

resource "authentik_application" "proxy-longhorn" {
  name              = "Longhorn"
  slug              = "longhorn"
  protocol_provider = authentik_provider_proxy.proxy-longhorn.id
}

##########
#homer#
##########

resource "authentik_provider_proxy" "proxy-homer" {
  name               = "Homer"
  authorization_flow = data.authentik_flow.default-authorization-flow.id
  external_host      = "https://homer.kube.home"
  mode               = "forward_single"
}

resource "authentik_application" "proxy-homer" {
  name              = "Homer"
  slug              = "homer"
  protocol_provider = authentik_provider_proxy.proxy-homer.id
}

#######
#vault#
#######

resource "authentik_provider_oauth2" "vault" {
  name      = "Vault"
  client_id = "vault"
  authorization_flow = data.authentik_flow.default-authorization-flow.id
}

resource "authentik_application" "oidc-vault" {
  name              = "Vault"
  slug              = "vault"
  protocol_provider = authentik_provider_oauth2.vault.id
}

data "kubernetes_config_map_v1" "root-ca" {
  metadata {
    name = "root-certificate-distribution"
  }
}

resource "vault_jwt_auth_backend" "vault-oidc-backend" {
    description         = "Authentik"
    path                = "oidc"
    type                = "oidc"
    oidc_discovery_url  = "http://ak-outpost-default-outpost.authentik.svc.cluster.local:9000"
    oidc_client_id      = authentik_provider_oauth2.vault.client_id
    oidc_client_secret  = authentik_provider_oauth2.vault.client_secret
    oidc_discovery_ca_pem = data.kubernetes_config_map_v1.root-ca.data.kube-home-crt
}

resource "vault_jwt_auth_backend_role" "vault-oidc-backend-role" {
  backend   = "oidc"
  role_name = "admin"
  token_policies = ["root", "default"]
  bound_audiences = [authentik_provider_oauth2.vault.client_id]
  allowed_redirect_uris = [
    "https://vault.kube.home/ui/vault/auth/oidc/oidc/callback",
    "https://vault.kube.home/oidc/callback",
    "https://localhost:8200/oidc/callback",
    "http://localhost:8200/oidc/callback",
  ]
  user_claim = "sub"
}

#########
#grafana#
#########

resource "authentik_provider_oauth2" "grafana" {
  name      = "Grafana"
  client_id = "grafana"
  authorization_flow = data.authentik_flow.default-authorization-flow.id
}

resource "authentik_application" "oidc-grafana" {
  name              = "Grafana"
  slug              = "grafana"
  protocol_provider = authentik_provider_oauth2.grafana.client_id
}

resource "vault_kv_secret_v2" "grafana-oauth-secrets" {
  mount                      = "kv"
  name                       = "kube/grafana"
  data_json                  = jsonencode(
  {
    oauth_client_id     = data.authentik_provider_oauth2.grafana.client_id
    oauth_client_secret = data.authentik_provider_oauth2.grafana.client_secret
  }
  )
}

#######
#users#
#######

resource "authentik_group" "authentik-admins" {
  name         = "Authentik External Admins"
  is_superuser = true
}


resource "authentik_user" "name" {
  username = "jkulzer"
  name     = "Johannes Kulzer"
  groups   = [
    authentik_group.authentik-admins.id,
    ]
}

