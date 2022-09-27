#!/bin/bash

helm template argo-cd argocd/argo-cd --include-crds -n argocd --values values.yaml \
    | kubectl apply -n argocd -f -
