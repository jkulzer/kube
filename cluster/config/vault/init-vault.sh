#!/bin/bash

helm template vault hashicorp/vault --include-crds -n vault --values values.yaml \
    | kubectl apply -n vault -f -
