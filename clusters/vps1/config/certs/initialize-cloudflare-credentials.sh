#!/bin/bash

read -p "Enter Cloudflare API key: " cloudflare_api_key

# Write the secret
kubectl create secret generic -n cert-manager cloudflare-credentials --from-literal "CF_API_TOKEN=$cloudflare_api_key"
