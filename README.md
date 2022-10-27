
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

  <p align="center">
	The source code for my own K3s-based Kubernetes-Cluster at home.
    <br/>
    <a href="https://github.com/jkulzer/kube/issues">Report Bug</a>
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

### Installation

1. Create a Kubernetes cluster with [https://k3s.io](https://k3s.io)
2. Disable services provided by K3s by adding these arguments to your K3s master arguments:
   ```sh
    --disable traefik --disable servicelb --disable local-storage --flannel-backend=none --disable-network-policy --cluster-cidr=10.42.0.0/16 --no-flannel
   ```
   This
   * Disables the default ingress controller Traefik (it will get replaced with ingress-nginx)
   * Disables the default LoadBalancer ServiceLB/Klipper(not sure how it's called) (it will get replaced with metallb)
   * Disables local-storage (it will get replaced with Longhorn)
   * Disables Flannel, networkPolicy and specifies a cluster CIDR. This will get useful for the install of the Flannel replacement Cilium.
3. Clone the repo
   ```sh
   git clone https://git.kube.home/jkulzer/kube.git
   ```

4. Install Cilium
   ```sh
   cd kube/cluster/config/cilium/
   ```

   ```sh
   bash init-cilium.sh
   ```

5. Install MetalLB
   ```sh
   cd ../metallb
   ```

   ```sh
   bash init-metallb.sh
   ```

   ```sh
   kubectl apply -f metallb-cm.yaml -n metallb-system
   ```
   (The ConfigMap mapping in the MetalLB Helm chart is broken, use this instead to define your config)
   Make sure to change the subnet to one that suits you. You can define a new subnet in your router (reccomended) or use an IP range in your existing subnet (you can look up how to define a range in the MetalLB documentation at https://metallb.universe.tf/configuration/)

5. Install NGINX-Ingress
   ```sh
   cd ../ingress-nginx
   ```
   ```
   bash init-ingress-nginx.sh
   ```
   It might complain about the secret not existing, but thats fine, you can create it later.

6. Install ArgoCD
   ```sh
   cd ../argocd
   ```

   ```sh
   bash init-argocd.sh
   ```
   You can also customize your ArgoCD URL in the values.yaml file.
   
7. Access ArgoCD
   ```sh
   kubectl get svc -n kube-system
   ```
   Search for the service ingress-nginx-controller and get the values from the field EXTERNAL-IP. Put this IP in your DNS server or your hosts file (and assign it the domain name in the values.yaml file for argocd).

   ```sh
   kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
   ```
   The output will be your password to log into ArgoCD. Don't forget to not copy the % at the end of the password.

   Now you should have a barebones Kubernetes cluster with a CD service (ArgoCD), a load balancer (MetalLB) and an ingress controller (NGINX-Ingress). Now you can do the next steps, installing a Git server and some way to store the database and repos of your Git server.
   


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
- [ ] Unified Node management
    - [ ] Uniform OS for every node
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
