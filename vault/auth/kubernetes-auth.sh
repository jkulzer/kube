vault write auth/kubernetes/config \
		disable_iss_validation=true \
        kubernetes_host="https://kubernetes.default.svc:443"
