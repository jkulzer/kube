#!/bin/bash

helm template argocd argo/argo-cd --namespace argocd --kube-version 1.27.5 --include-crds --values values.yaml \
    | kubectl apply -n argocd -f -
