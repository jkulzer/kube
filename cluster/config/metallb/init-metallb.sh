#!/bin/bash

helm template metallb metallb/metallb --include-crds -n metallb-system --values values.yaml \
    | kubectl apply -n metallb-system -f -
