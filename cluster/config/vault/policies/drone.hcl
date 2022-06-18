path "kv/kube/drone"                        { capabilities = ["read", "list"] }
path "kv/data/kube/drone"    { capabilities = ["read", "list"] }
path "kv/kube/drone/*"    { capabilities = ["read", "list"] }
path "kv/kube/drone/gitea-client-id"    { capabilities = ["read", "list"] }
path "kv/kube/drone/gitea-client-secret"    { capabilities = ["read", "list"] }
path "kv/kube/drone/drone-rpc-secret"    { capabilities = ["read", "list"] }
path "kv/data/kube/drone/gitea-client-id/*"    { capabilities = ["read", "list"] }
path "kv/data/kube/drone/gitea-client-secret/*"    { capabilities = ["read", "list"] }
path "kv/data/kube/drone/drone-rpc-secret/*"    { capabilities = ["read", "list"] }
path "kv/kube/drone/drone-rpc-secret/*"    { capabilities = ["read", "list"] }
path "kv/data/kube/drone/drone-rpc-secret/*"    { capabilities = ["read", "list"] }

