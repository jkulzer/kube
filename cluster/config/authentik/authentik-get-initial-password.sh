#!/bin/bash

echo "The default password is akadmin"

#Prints the password
vault kv get -field=initialadminpassword kv/kube/authentik
