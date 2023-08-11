vault write auth/oidc/config \
         oidc_discovery_url="https://authentik.kube.home/application/o/vault-test/" \
         oidc_client_id="xtBZvoP5ao2bWFPgQ84iC2SbclvOQEzHePrUU4AJ" \
         oidc_client_secret="3knvSPnMcAq51V6iXBgE7q5mJp4MdBOf3zQKzl4JQbnMQODRmKXrNrAUkl9RyCChaajdoMIiVondehSkoQc6DxJHD3y2C4kc8GPC5hf4SBkhMBUO4l3AqDUYwT4gGIKs" \
         default_role="reader"
vault write auth/oidc/role/reader \
      bound_audiences="xtBZvoP5ao2bWFPgQ84iC2SbclvOQEzHePrUU4AJ" \
      allowed_redirect_uris="http://vault.kube.home/ui/vault/auth/oidc/oidc/callback" \
      allowed_redirect_uris="http://vault.kube.home/oidc/callback" \
      allowed_redirect_uris="https://localhost:8200/oidc/callback" \
      allowed_redirect_uris="http://localhost:8200/oidc/callback" \
      user_claim="sub" \
      policies="reader"
