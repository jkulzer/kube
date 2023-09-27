{ config, pkgs, lib, ... }:
let
  fetchGitHubSSHKey = import ./ssh-keys.nix { username = "jkulzer";};
in
{
  imports = [
    ./hardware-configuration.nix
    ./k3s.nix
  ];



  boot.cleanTmpDir = true;
  zramSwap.enable = true;
  networking.hostName = "temp";
  
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keyFiles = [
    "${fetchGitHubSSHKey}"
  ];
  users.users.johannes.openssh.authorizedKeys.keys = [
    "${fetchGitHubSSHKey}"
  ];

#  nix.settings.experimental-features = [ "nix-command" "flakes" ];
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
}