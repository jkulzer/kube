#!/bin/bash

kubectl -n authelia get secret ldap-admin-user-pass -o jsonpath="{.data.LLDAP_LDAP_USER_PASS}"  | base64 -d
