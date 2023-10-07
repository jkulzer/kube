#!/bin/bash

read -p "Enter Cloudflare API key: " cloudflare_api_key

read -p "Enter Cloudflare EMail Address: " cloudflare_mail_address

# Write the secret
kubectl create secret generic -n external-dns cloudflare-credentials --from-literal="CF_API_TOKEN=$cloudflare_api_key" --from-literal="CF_API_EMAIL=$cloudflare_mail_address"
