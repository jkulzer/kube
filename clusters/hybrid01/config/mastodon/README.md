# Restore from backup

## PVCs
Create the PVCs to restore into:
```
k apply -f mastodon-pvc.yaml
```

Create the ReplicationDestinations that will restore into the PVCs:
```
k apply -f mastodon-backup-restore.yaml
```

## Postgres
Create the mastodon cluster from backup:
```
k apply -f mastodon-cnpg-restore.yaml
```

Don't forget to remove the replicationdestination after the backup has finished syncing
