#!/bin/bash

#sets the correct vault token
export VAULT_TOKEN=$(kubectl get secret -n vault vault-unseal-keys -o jsonpath="{.data.vault-root}" | base64 -d)

#Prints the password
vault kv get -field=initialadminpassword kv/kube/authentik
