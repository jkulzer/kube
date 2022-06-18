#!/bin/bash

helm template gitea gitea-charts/gitea -n gitea --values values.yaml \
    | kubectl delete -n gitea -f -
