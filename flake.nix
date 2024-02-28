{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ flake-parts, nix-on-droid, ... }: let
    root = ./.;
    modules = "${root}/modules";
    configs = "${root}/configs";
  in flake-parts.lib.mkFlake { inherit inputs; } {
    systems = [ "aarch64-linux" ];

    flake = {
      nixOnDroidModules = {
        default = "${modules}/droid";
      };
      nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
        modules = [
	  "${configs}/droid"
          "${modules}/droid"
	  ./home.nix
	];
	extraSpecialArgs = inputs // { inherit root modules configs; };
      };
    };
  };
}
