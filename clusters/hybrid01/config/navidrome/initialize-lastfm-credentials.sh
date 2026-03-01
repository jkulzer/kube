#!/bin/bash

read -p "Enter Lastfm API Key: " lastfm_api_key

read -p "Enter Shared Secret: " lastfm_shared_secret

# Write the secret
kubectl create secret generic -n navidrome lastfm-credentials --from-literal="ND_LASTFM_APIKEY=$lastfm_api_key" --from-literal="ND_LASTFM_SECRET=$lastfm_shared_secret"
