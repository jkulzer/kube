#!/bin/bash

read -p "Username: " api_key

read -p "Password: " api_secret

# Write the secret
kubectl create secret generic -n authelia smtp-credentials --from-literal="SMTP_USERNAME=$api_key" --from-literal="SMTP_PASSWORD=$api_secret"
