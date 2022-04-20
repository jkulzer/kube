
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
    <img src="images/kubernetes.svg" alt="Logo" width="80" height="80">
  </a>

<h3 align="center">Kubernetes Cluster</h3>

  <p align="center">
    project_description
    <br />
    <a href="https://github.com/jkulzer/kube"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/jkulzer/kube">View Demo</a>
    ·
    <a href="https://github.com/jkulzer/kube/issues">Report Bug</a>
    ·
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
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

[![Product Name Screen Shot][product-screenshot]](https://example.com)

<p align="right">(<a href="#top">back to top</a>)</p>



### Uses:

<table>
	<tr>
		<td><img width="64" src="https://cncf-branding.netlify.app/img/projects/kubernetes/icon/color/kubernetes-icon-color.svg"></td>
		<td><a href="https://kubernetes.io">Kubernetes</a></td>
		<td>Kubernetes.</td>
	</tr>

	<tr>
		<td><img width="64" src="https://k3s.io/images/logo-k3s.svg"></td>
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
</table>

* [ArgoCD](https://argo-cd.readthedocs.io/en/stable/)
* [K3S](https://k3s.io/)
* [Gitea](https://docs.gitea.io/en-us/)
* [Hashicorp Vault](https://vaultproject.io/)
* [Authentik](https://goauthentik.io/)
* [itzg Minecraft Server](https://https://github.com/itzg/docker-minecraft-server/)

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started

This is an example of how you may give instructions on setting up your project locally.
To get a local copy up and running follow these simple example steps.

### Prerequisites

This is an example of how to list things you need to use the software and how to install them.
* npm
  ```sh
  npm install npm@latest -g
  ```

### Installation

1. Create a Kubernetes cluster with [https://k3s.io](https://k3s.io)
2. Clone the repo
   ```sh
   git clone https://git.kube.home/jkulzer/kube.git
   ```
3. cd into kube/argocd
   ```sh
   cd kube/argocd
   ```
4. Apply ArgoCD
   ```sh
   kubectl apply -f argocd.yaml -n argocd
   ```

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- USAGE EXAMPLES -->
## Usage

Use this space to show useful examples of how a project can be used. Additional screenshots, code examples and demos work well in this space. You may also link to more resources.

_For more examples, please refer to the [Documentation](https://example.com)_

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- ROADMAP -->
## Roadmap

- [x] GitOps with ArgoCD
- [x] Automatic Certificate Management
- [x] SSO with Authentik
- [x] NFS
    - [x] Jellyfin
- [ ] Longhorn Backups
    - [ ] MinIO on RasPi
- [ ] Monitoring
- [ ] Paperless-NGX

See the [open issues](https://github.com/jkulzer/kube/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#top">back to top</a>)</p>


<!-- LICENSE -->
## License

Distributed under the GNU GPL v3 License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Project Link: [https://github.com/jkulzer/kube](https://github.com/jkulzer/kube)

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

* []()
* []()
* []()

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/jkulzer/kube.svg?style=for-the-badge
[product-screenshot]: images/screenshot.png
