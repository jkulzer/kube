#!/bin/bash

read -p "Enter Discord Webhook: " discord_webhook

# Write the secret to Vault
vault kv put kv/kube/alertmanager discord-webhook="$discord_webhook"
