{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    ez-configs.url = "github:ehllie/ez-configs"; 
    
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
    imports = [
      inputs.ez-configs.flakeModule
    ];

    systems = [
      "x86_64-linux"
    ];

    ezConfigs = let
      root = ./.;
      modules = "${root}/modules";
      configs = "${root}/configs";
    in {
      globalArgs = inputs;

      inherit root;

      home = {
        modulesDirectory = "${modules}/home";
        configurationsDirectory = "${configs}/home";
      };
      nixos = {
        modulesDirectory = "${modules}/nixos";
        configurationsDirectory = "${configs}/nixos";
      };
      darwin = {
        modulesDirectory = "${modules}/darwin";
        configurationsDirectory = "${configs}/darwin";
      };
<<<<<<< HEAD
=======

>>>>>>> 3ad2e09 (attempt to fix some errors in nix repl)
    };
  };
}
