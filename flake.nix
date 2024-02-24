{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";
    
    nix-colors = {
      url = "github:misterio77/nix-colors";
    };

    getchoo = {
      url = "github:getchoo/nix-exprs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    trusted-substituters = [
      "https://getchoo.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "getchoo.cachix.org-1:ftdbAUJVNaFonM0obRGgR5+nUmdLMM+AOvDOSx0z5tE="
    ];
  };

  outputs = inputs@{ flake-parts, ... }: flake-parts.lib.mkFlake { inherit inputs; } {
    flake = {
      nixosConfigurations = import ./configs/hosts inputs;
      homeConfigurations = import ./configs/users inputs;
    };
    systems = [
      "x86_64-linux"
    ];
  };
}
