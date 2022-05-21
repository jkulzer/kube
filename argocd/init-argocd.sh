#!/bin/bash

helm template argocd argocd/argo-cd --include-crds -n argocd --values values.yaml \
    | kubectl apply -n argocd -f -
