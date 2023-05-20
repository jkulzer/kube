How to get the Vault unseal key:

```sh
kubectl get secret -n vault vault-unseal-keys -o jsonpath="{.data.vault-root}" | base64 -d
```
