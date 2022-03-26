path "internal-certs*"                        { capabilities = ["read", "list"] }
path "internal-certs/sign/kube-internal"    { capabilities = ["create", "update", "read", "list"] }
path "internal-certs/issue/kube-internal"   { capabilities = ["create"] }
