path "internal-certs*"                        { capabilities = ["read", "list"] }
path "internal-certs/sign/kube-home"    { capabilities = ["create", "update", "read", "list"] }
path "internal-certs/issue/kube-home"   { capabilities = ["create"] }
