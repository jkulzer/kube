#!/bin/bash

read -p "Enter Discord Webhook: " discord_webhook_url

# Write the secret
kubectl create secret generic -n alertmanager-discord discord-webhook --from-literal="webhook-url=$discord_webhook_url"
