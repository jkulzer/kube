resource "hcloud_server" "vps1" {
  name        = "vps1-k3s"
  server_type = "cax21"
  image       = "ubuntu-22.04"
  location    = "nbg1"

  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }

  ssh_keys = ["Desktop from GitHub"]

  user_data = "runcmd:\n  - curl https://raw.githubusercontent.com/elitak/nixos-infect/master/nixos-infect | PROVIDER=hetznercloud NIX_CHANNEL=nixos-unstable bash 2>&1 | tee /tmp/infect.log"

  depends_on = [
    hcloud_ssh_key.desktop-from-github,
  ]
}

resource "hcloud_ssh_key" "desktop-from-github" {
  name       = "Desktop from GitHub"
  public_key = data.http.key-from-github.response_body

  depends_on = [ 
    data.http.key-from-github
  ]
}

data "http" "key-from-github" {
  url = "https://github.com/jkulzer.keys"
}

output "ip-address" {
  value = hcloud_server.vps1.ipv4_address
}
