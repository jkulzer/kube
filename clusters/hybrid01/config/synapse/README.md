# Restore from backup

## PVCs
Create the PVCs to restore into:
```
k apply -f synapse-pvc.yaml
```

Create the ReplicationDestinations that will restore into the PVCs:
```
k apply -f synapse-backup-restore.yaml
```

## Postgres
Create the MAS cluster from backup:
```
k apply -f mas-cnpg-restore.yaml
```
Create the Synapse cluster from backup:
```
k apply -f synapse-cnpg-restore.yaml
```
