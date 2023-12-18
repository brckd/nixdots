{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
	  ./configuration.nix
          home-manager.nixosModules.home-manager
          {
	    home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.bricked = import ./home.nix;
	    };
          }
        ];
      };
    };
  };
}
