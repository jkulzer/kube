#!/bin/bash

helm template cilium cilium/cilium --include-crds -n kube-system --values values.yaml \
    | kubectl apply -n kube-system -f -
