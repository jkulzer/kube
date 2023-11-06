{ pkgs, ... }: 
let
  fetchGitHubSSHKey = import ./ssh-keys.nix { username = "jkulzer";};
in
{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix # generated at runtime by nixos-infect
    
    ./k3s.nix # Kubernetes server
  ];

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = false;
  networking.hostName = "vps1-k3s";
  services.openssh = { 
    enable = true;
    settings = {
    	PasswordAuthentication = false;
    };
  };
  users.users.root.openssh.authorizedKeys.keyFiles = [
    "${fetchGitHubSSHKey}"
  ];
  users.users.johannes.openssh.authorizedKeys.keyFiles = [
    "${fetchGitHubSSHKey}"
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # System Tools
    curl
    wget
    dig # DNS lookup
    htop # like task manager
    openssl # THE cryptographic library

    # terminal multiplexer (useful when having to debug from tty)
    tmux

    # fzf (fuzzy finder) (dependency for fzf zsh plugin)
    fzf

    # Coding
    cargo # Rust

  ];

  users.users.johannes= {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      
      gh # Github login

      # Kubernetes stuff
      kubectl
      kustomize
      kubernetes-helm
      talosctl
      kube-capacity # Shows how much resources are allocated by the cpu/memory requests/limits
   ];
  };


  # This should fix a ArgoCD problem with too many open files
  security.pam.loginLimits = [
    {
      domain = "*";
      type = "-";
      item = "nofile";
      value = "65536";
    }
  ];

  programs.git = {
    enable = true;
    config = {
      user = {
        name = "jkulzer";
        email = "git@jkulzer.dev";
      };
      core.editor = "nvim";
      init.defaultBranch = "main";
      pull.rebase = false;
    }; # config closed
  };

  # Sets default shell to ZSH
  users.defaultUserShell = pkgs.zsh;

  programs.zsh = {
    enable = true;
    # Disables the startup wizard
    shellInit = "zsh-newuser-install() { :; }";
    # Useful syntax stuff
    autosuggestions.enable = true;
    enableCompletion = true;
    # Enables syntax highlighting
    syntaxHighlighting = {
      enable = true;
    };
    # ZSH Plugin system
    ohMyZsh = {
      enable = true;
      plugins = [ 
        "kubectl" # Shortens kubectl to k and has other useful aliases
        "vi-mode" # Enables editing of commands with vim commands (activate normal mode with esc)
        "fzf" # Fuzzy finder
      ];
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      line_break = {
        disabled = true;
      };
    };
  };

  networking.firewall = {
    enable = true;
  #   extraCommands = ''
  #   # Block the external accessibility of the k8s api 6443 on eth0 (the interface with the external IP)
  #   iptables -A INPUT -i eth0 -p tcp --dport 6443 -j DROP
  # '';
  };

  services.tailscale.enable = true;

  boot.kernel.sysctl = {
    "net.ipv4.conf.all.forwarding" = true;
    "net.ipv6.conf.all.forwarding" = true;
  };

  system.stateVersion = "23.11";
}
