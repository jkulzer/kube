kustomize build ../cluster/config/prometheus-crds --enable-helm | kubectl apply --server-side=true --force-conflicts=true -f -
kustomize build ../cluster/config/istio-crds --enable-helm | kubectl apply --server-side=true --force-conflicts=true -f -
kustomize build ../cluster/config/istiod --enable-helm | kubectl apply --server-side=true --force-conflicts=true -f -
kustomize build ../cluster/config/rook-ceph --enable-helm | kubectl apply --server-side=true --force-conflicts=true -f -
kustomize build ../cluster/config/argocd --enable-helm | kubectl apply --server-side=true --force-conflicts=true -f -
#kubectl apply -f ../cluster/repository.yaml
#kubectl apply -f ../cluster/main.yaml
