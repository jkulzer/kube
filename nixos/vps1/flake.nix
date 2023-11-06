{
  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, nixvim, ... }: {
    nixosConfigurations.vps1-k3s= nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      pkgs = import nixpkgs {
        system = "aarch64-linux";
        config.allowUnfree = true;
      };
      modules = [
        ./configuration.nix
	nixvim.nixosModules.nixvim
	{
	 programs = import ./neovim.nix;
	}
	
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.johannes = {
	   imports = [
	     ./home.nix # Misc config
	     ./helm.nix # Helm repo configuration
	   ];
	 };
        }
      ];
    };
  };
}
