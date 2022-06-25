### Prepare the nodes

1. Install the upgrade controller
   ```sh
   kubectl apply -f system-upgrade-controller.yaml
   ```

2. Change the version in the ```upgrade-job.yaml``` file to a valid K3S version (you can find the latest version via the K3S Github repo (https://github.com/k3s-io/k3s/releases)

3. Run the upgrade job for the worker nodes
   ```sh
   kubectl apply -f upgrade-job-worker.yaml
   ```
4. Shut down the worker nodes

5. Run the upgrade job for the control-plane nodes
   ```sh
   kubectl apply -f upgrade-job-control-plane.yaml
   ```

6. Reboot the control-plane nodes

7. Power on the worker nodes
