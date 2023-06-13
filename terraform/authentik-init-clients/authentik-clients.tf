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

resource "authentik_outpost" "outpost" {
  name = "Default Outpost"
  service_connection = authentik_service_connection_kubernetes.local.id
  protocol_providers = [
    authentik_provider_proxy.proxy-auth-test.id,
    authentik_provider_proxy.proxy-longhorn.id,
    authentik_provider_proxy.proxy-homer.id
  ]
  # the config must be encoded in json, \" is required to escape the quotes
  config = "{\"authentik_host\": \"http://authentik.authentik.svc.cluster.local:80\",\"authentik_host_browser\": \"https://authentik.kube.home\"}"
}


#########
#testapp#
#########

resource "authentik_provider_proxy" "proxy-auth-test" {
  name               = "Proxy Auth Test"
  authorization_flow = data.authentik_flow.default-authorization-flow.id
  external_host      = "https://test.kube.home"
  mode               = "forward_single"
}

resource "authentik_application" "proxy-auth-test-application" {
  name              = "Proxy Auth Test"
  slug              = "proxy-auth-test"
  protocol_provider = authentik_provider_proxy.proxy-auth-test.id
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