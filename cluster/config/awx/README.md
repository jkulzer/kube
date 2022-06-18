## After Install
1.  Get admin password (don't forget to remove the % at the end)
    ```sh
    kubectl get secrets -n awx awx-admin-password -o jsonpath="{.data.password}" | base64 --decode
    ```
	
