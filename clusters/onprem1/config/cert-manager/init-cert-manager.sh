#!/bin/bash

helm template cert-manager jetstack/cert-manager --namespace cert-manager --kube-version 1.27.5 --include-crds --values values.yaml \
    | kubectl apply -n cert-manager -f -
