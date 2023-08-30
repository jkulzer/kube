
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
    <img src="https://raw.githubusercontent.com/kubernetes/kubernetes/master/logo/logo.png" alt="Logo" width="80" height="80">
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
		<td><img width="64" src="https://raw.githubusercontent.com/kubernetes/kubernetes/master/logo/logo.png"></td>
		<td><a href="https://kubernetes.io">Kubernetes</a></td>
		<td>Just Kubernetes</td>
	</tr>
	<tr>
		<td><img width="64" src="https://landscape.cncf.io/logos/argo.svg"></td>
		<td><a href="https://argoproj.github.io/argo-cd">ArgoCD</a></td>
		<td>Automatically deploys manifests from git repo</td>
	</tr>
	<tr>
		<td><img width="64" src="https://github.com/jetstack/cert-manager/raw/master/logo/logo.png"></td>
		<td><a href="https://cert-manager.io">cert-manager</a></td>
		<td>Certificate Management for Kubernetes</td>
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
		<td><img width="64" src="https://istio.io/v1.7/img/istio-whitelogo-bluebackground-framed.svg"></td>
		<td><a href="https://istio.io/">Istio</a></td>
		<td>The leading Kubernetes service mesh</td>
	</tr>
	<tr>
		<td><img width="64" src="https://landscape.cncf.io/logos/rook.svg"></td>
		<td><a href="https://rook.io/">Rook/Ceph</a></td>
		<td>Highly scalable distributed storage</td>
	</tr>
	<tr>
		<td><img width="64" src="https://github.com/metallb/metallb/raw/main/website/static/images/logo/metallb-blue.png"></td>
		<td><a href="https://metallb.org/">MetalLB</a></td>
		<td>A load balancer</td>
	</tr>
	<tr>
		<td><img width="64" src="https://landscape.cncf.io/logos/prometheus.svg"></td>
		<td><a href="https://prometheus.io/">Prometheus</a></td>
		<td>Monitoring Scraper</td>
	</tr>
	<tr>
		<td><img width="64" src="https://landscape.cncf.io/logos/goldilocks.svg"></td>
		<td><a href="https://www.fairwinds.com/goldilocks">Goldilocks</a></td>
		<td>CPU/Memory Reqests Reccomender</td>
	</tr>
	<tr>
		<td><img width="64" src="https://landscape.cncf.io/logos/kyverno.svg"></td>
		<td><a href="https://kyverno.io">Kyverno</a></td>
		<td>Policy Management</td>
	</tr>
	<tr>
		<td><img width="64" src="https://landscape.cncf.io/logos/grafana-loki.svg"></td>
		<td><a href="https://grafana.com/oss/loki">Loki</a></td>
		<td>Log Aggregator</td>
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

... //TODO 
Add missing steps

7. After some time, get the certificate generated for the domain using the following command:
```sh
kubectl get configmaps wildcard-kube-home-distribution -o jsonpath='{.data}' | jq -r '.["kube-home.crt"]' > /tmp/kube-home.crt
```

<p align="right">(<a href="#top">back to top</a>)</p>


<!-- ROADMAP -->
## Roadmap

- [x] GitOps with ArgoCD
- [x] Automatic Certificate Management
- [ ] SSO with Authentik
    - [ ] ArgoCD
    - [ ] Drone
    - [ ] Gitea
    - [ ] Grafana
    - [ ] Harbor
    - [x] Homer
    - [x] Longhorn
    - [ ] Openproject
    - [x] Prometheus
    - [x] Alertmanager
    - [ ] Vault
- [ ] NFS
    - [ ] Jellyfin
- [x] Longhorn Backups
    - [ ] NFS on RasPi (or Minio?)
    - [ ] Automatic Backups ~~weekly~~ daily
- [ ] Monitoring
    - [x] Secure Prometheus
    - [x] Create nice dashboard
    - [x] Configure alerting via Discord
- [x] Renovate
- [ ] Paperless-NGX
- [ ] Gitea
    - [ ] OAuth or LDAP SSO
- [ ] Harbor
- [x] Unified Node management
    - [x] Talos

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
* [BeryJu](https://github.com/BeryJu/k8s)

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
