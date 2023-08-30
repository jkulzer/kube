talosctl gen secrets -o secrets.yaml
talosctl gen config --with-secrets secrets.yaml homeprod01 https://node1.nodes.kube.home:6443 --config-patch @patch.yaml
talosctl apply-config --insecure -n node1.nodes.kube.home --file controlplane.yaml
talosctl bootstrap -n 192.168.42.33 --talosconfig talosconfig
talosctl kubeconfig --talosconfig talosconfig -n 192.168.42.33
talosctl apply-config --insecure --nodes 192.168.42.34 --file worker.yaml
talosctl apply-config --insecure --nodes 192.168.42.35 --file worker.yaml
