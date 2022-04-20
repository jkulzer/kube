path "kv/kube/authentik"                        { capabilities = ["read", "list"] }
path "kv/data/kube/authentik"    { capabilities = ["read", "list"] }
path "kv/data/kube/authentik/postgrespass/*"    { capabilities = ["read", "list"] }
path "kv/kube/authentik/postgrespass"    { capabilities = ["read", "list"] }
path "kv/kube/authentik/*"    { capabilities = ["read", "list"] }
path "kv/kube/authentik/postgrespass/*"    { capabilities = ["read", "list"] }
path "kv/kube/authentik/redispass/*"    { capabilities = ["read", "list"] }
path "kv/data/kube/authentik/redispass/*"    { capabilities = ["read", "list"] }

