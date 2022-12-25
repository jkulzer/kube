# Unified OS Image

This generates a ISO which automatically installs an Arch Linux install used in the Kubernetes Cluster.
Uses [archiso](https://wiki.archlinux.org/title/Archiso) to do it. A Docker container for building the ISO is provided, but needs to be run as root (as archiso wants to do things with mounting).

## Structure

```sh
📁 archiso-profile              #contains the profile used by mkarchiso
├─📁 airootfs                   #contains the ISOs filesystem
├──📁 etc
├───📁 systemd
├────📁 system
├─────📄 install-script.service #service file for install script which runs on every boot
├──📁 root
├───📄 install-script.sh        #install script that gets executed every boot
| ...
```
## Customization
