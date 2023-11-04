# Groups
1. The "kubeadmin" group gets access to all administrative service for Kubernetes

# Default admin credential
```
kubectl get secret -n authelia ldap-admin-user-pass -o jsonpath="{.data.LLDAP_LDAP_USER_PASS}" | base64 -d
```
