path "internal-certs*"                        { capabilities = ["read", "list"] }
path "internal-certs/sign/2hu-net"    { capabilities = ["create", "update", "read", "list"] }
path "internal-certs/issue/2hu-net"   { capabilities = ["create"] }
