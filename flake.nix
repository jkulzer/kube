{
  description = "rust dev env";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
      in {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            kubectl
            kustomize
            kubernetes-helm
            talosctl
            kube-capacity
            opentofu
            jq
          ];
        };
      }
    );
}
