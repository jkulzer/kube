
<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
<!-- [![Contributors][contributors-shield]][contributors-url] -->


<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://git.kube.home/johannes/kube">
    <img src="https://cncf-branding.netlify.app/img/projects/kubernetes/icon/color/kubernetes-icon-color.svg" alt="Logo" width="80" height="80">
  </a>

<h3 align="center">Kubernetes Cluster</h3>
	
<p align="center">The source code for my own K3s-based Kubernetes-Cluster at home.</p>

<h3 align="center" color="yelow">Currently in Alpha</h3>

<p align="center">Repo is incomplete and in active development</p>
  
	  
  <p align="center">
    <a href="https://github.com/jkulzer/kube/issues">Report Bug</a>
    <br/>
    <a href="https://github.com/jkulzer/kube/issues">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project


<p align="right">(<a href="#top">back to top</a>)</p>



### Used technology:

<table>
	<tr>
		<td><img width="64" src="https://cncf-branding.netlify.app/img/projects/kubernetes/icon/color/kubernetes-icon-color.svg"></td>
		<td><a href="https://kubernetes.io">Kubernetes</a></td>
		<td>Just Kubernetes</td>
	</tr>
	<tr>
		<td><img width="64" src="https://cncf-branding.netlify.app/img/projects/k3s/icon/color/k3s-icon-color.svg"></td>
		<td><a href="https://k3s.io">K3s</a></td>
		<td>Lightweight Kubernetes distribution with ARM support</td>
	</tr>
	<tr>
		<td><img width="64" src="https://cncf-branding.netlify.app/img/projects/argo/icon/color/argo-icon-color.svg"></td>
		<td><a href="https://argoproj.github.io/argo-cd">ArgoCD</a></td>
		<td>Automatically deploys manifests from git repo</td>
	</tr>
	<tr>
		<td><img width="64" src="https://github.com/jetstack/cert-manager/raw/master/logo/logo.png"></td>
		<td><a href="https://cert-manager.io">cert-manager</a></td>
		<td>Certificate Management for Kubernetes</td>
	</tr>
	<tr>
		<td><img width="64" src="https://cdn.jsdelivr.net/gh/cilium/cilium@master/Documentation/images/logo-solo.svg"></td>
		<td><a href="https://cilium.io">Cilium</a></td>
		<td>Container Network interface with encryption and observability</td>
	</tr>
	<tr>
		<td><img width="64" src="https://raw.githubusercontent.com/go-gitea/gitea/main/assets/favicon.svg"></td>
		<td><a href="https://gitea.io">Gitea</a></td>
		<td>Lightweight Git server</td>
	</tr>
	<tr>
		<td><img width="64" src="https://raw.githubusercontent.com/grafana/grafana/main/public/img/grafana_icon.svg"></td>
		<td><a href="https://grafana.com/">Grafana</a></td>
		<td>Dashboard that displays metrics from Prometheus</td>
	</tr>
	<tr>
		<td><img width="64" src="https://raw.githubusercontent.com/kubernetes/community/master/icons/svg/resources/unlabeled/ing.svg"></td>
		<td><a href="https://kubernetes.github.io/ingress-nginx/">NGINX-Ingress</a></td>
		<td>The ingress controller developed by Kubernetes</td>
	</tr>
	<tr>
		<td><img width="64" src="https://cncf-branding.netlify.app/img/projects/longhorn/icon/color/longhorn-icon-color.svg"></td>
		<td><a href="https://longhorn.io/">Longhorn</a></td>
		<td>Uncomplicated distributed storage</td>
	</tr>
	<tr>
		<td><img width="64" src="https://github.com/metallb/metallb/raw/main/website/static/images/logo/metallb-blue.png"></td>
		<td><a href="https://metallb.org/">MetalLB</a></td>
		<td>A load balancer</td>
	</tr>
	<tr>
		<td><img width="64" src="https://simpleicons.org/icons/vault.svg"></td>
		<td><a href="https://vaultproject.io/">Hashicorp Vault</a></td>
		<td>Easy secrets management with Service Account Auth</td>
	</tr>
	<tr>
		<td><img width="64" src="https://raw.githubusercontent.com/banzaicloud/bank-vaults/main/docs/images/logo/bank-vaults-logo.svg"></td>
		<td><a href="https://banzaicloud.com/docs/bank-vaults/mutating-webhook/">Vault Mutating Webhook</a></td>
		<td>Allows to embed secrets from Vault in ConfigMaps, Environmental Variables etc.</td>
	</tr>
	<tr>
		<td><img width="64" src="https://cncf-branding.netlify.app/img/projects/prometheus/icon/color/prometheus-icon-color.svg"></td>
		<td><a href="https://prometheus.io/">Prometheus</a></td>
		<td>Monitoring Scraper</td>
	</tr>
</table>

* [itzg Minecraft Server](https://https://github.com/itzg/docker-minecraft-server/)

Repo Folder Structure

```sh
📁 cluster            #all cluster-relevant stuff
├─📁 applications     #this is where all application definitions for argo-cd live 
├─📁 config           #here are all Chart.yaml, values.yaml and other deployment files
├─📄 main.yaml        #this file defines the app of apps for argocd (it applies everything in the applications folder)
└─📄 repository.yaml  #this file defines the repo from where this repo gets pulled in argo-cd
```

Example config folder structure

```sh
📁 config                       #the config directory from above
| ...
├─📁 example-helm-application   #the folder of an application that gets deployed with helm and argocd
├──📄 Chart.yaml                #this file defines the helm chart that the application uses
├──📄 values.yaml               #this file configures aspects of the application
├─📁 example-manifest           #the folder of an application that has a manually written manifest
├──📄 example-manifest.yaml     #this is a manually written manifest for an application which doesn't have a helm chart
| ...
```

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started

This is a possible way to get this setup running on your own cluster. It assumes you use K3s. I have never tested it, so use it at your own discretion.

### Prerequisites
1. Clone repo

```sh
git clone https://github.com/jkulzer/kube.git
cd kube
```
### Installing the OS
2. Generate OS ISO
```sh
cd images/unified-os-iso
sudo docker compose build
sudo docker compose up
```
This contains further instructions for customizing the ISO: https://github.com/jkulzer/kube/tree/main/images/unified-os-iso

3. Install the OS using the ISO on your node

4. Adjust the password set while customizing the ISO in `ansible/cluster-init`

5. Run the playbook with:

```sh
sudo docker compose build
sudo docker compose up
```

6. Log into the server and grab the kubeconfig located at `/etc/rancher/k3s/k3s.yaml`

7. After some time, get the certificate generated for the domain using the following command:
```sh
kubectl get configmaps kube-root-ca.crt -o jsonpath='{.data}' | jq -r '.["ca.crt"]'
```

<p align="right">(<a href="#top">back to top</a>)</p>


<!-- ROADMAP -->
## Roadmap

- [x] GitOps with ArgoCD
- [x] Automatic Certificate Management
- [ ] SSO with Authentik
    - [ ] ArgoCd
    - [ ] Cilium/Hubble
    - [ ] Drone
    - [ ] Gitea
    - [ ] Grafana
    - [x] Hajimari
    - [x] Longhorn
    - [ ] Openproject
    - [ ] Prometheus
    - [ ] Vault
- [x] NFS
    - [x] Jellyfin
- [x] Longhorn Backups
    - [x] NFS on RasPi
    - [x] Automatic Backups ~~weekly~~ daily
- [ ] Monitoring
    - [ ] Secure Prometheus
    - [ ] Create nice dashboard
    - [ ] Configure alerting via Discord
- [ ] Cilium
    - [ ] Wireguard with Cilium
    - [ ] Observability with Cilium
- [x] Renovate
- [ ] Paperless-NGX
- [x] Unified Node management
    - [x] Uniform OS for every node
    - [x] Uniform OS generated in Docker container
    - [ ] Automatic OS updates
    - [ ] Automated OS install with Ansible

See the [open issues](https://github.com/jkulzer/kube/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Project Link: [https://github.com/jkulzer/kube](https://github.com/jkulzer/kube)

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

* [k8s@home](https://k8s-at-home.com/)

Helpful repos:
* [khuedoan/homelab](https://github.com/khuedoan/homelab)
* [onedr0p/home-ops](https://github.com/onedr0p/home-ops)
* [danmanners/homelab-kube-cluster](https://github.com/danmanners/homelab-kube-cluster)

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
