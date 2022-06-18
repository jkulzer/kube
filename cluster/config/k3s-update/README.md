### Prepare the nodes

1. Install the upgrade controller
   ```sh
   kubectl apply -f system-upgrade-controller.yaml
   ```
2. List all nodes
   ```sh
   kubectl get nodes
   ```
3. Label the nodes to upgrade
   ```sh
   kubectl label node <node-to-upgrade> k3s-upgrade=true
   ```

:warning: The version of the worker nodes should always be lower or equal compared to the master node(s) so upgrade your master nodes first and the worker nodes afterwards

4. Change the version in the ```upgrade-job.yaml``` file to a valid K3S version (you can find the latest version via the K3S Github repo (https://github.com/k3s-io/k3s/releases)

5. Run the upgrade job
   ```sh
   kubectl apply -f upgrade-job.yaml
   ```
