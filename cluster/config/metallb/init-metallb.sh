#!/bin/bash

helm template metallb metallb/metallb --include-crds -n argocd --values values.yaml \
    | kubectl apply -n metallb-system -f -
