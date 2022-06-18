vault write auth/kubernetes/role/kube-home\
    bound_service_account_names=issuer \
    bound_service_account_namespaces=kube-system\
    policies=pki-internal-certs\
    ttl=1h
