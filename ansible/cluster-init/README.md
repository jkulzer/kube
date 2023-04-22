## Create the Cluster

1. Edit the hosts file at 'playbook/inventory/hosts.yml' to include your created VMs or hosts.
```yaml
all:
  children:
    primary:
      hosts:
        node1.nodes.kube.home:
    other-nodes:
      hosts:
        node2.nodes.kube.home:
        node3.nodes.kube.home:
```
You need to have one node that creates the cluster ('all.children.primary.hosts'). All other nodes get put to 'all.children.other-nodes.hosts' and join the cluster created as etcd nodes.

2. Ensure that the domain 'node1.nodes.kube.home' points to one of your nodes. If you have a different domain you need to change it in the file 'playbook/playbook.yml'.

3. Run the playbook:
```sh
sudo docker compose up
```
