{
  description = "NixOS configuration";

  outputs = inputs @ {
    flake-parts,
    nix-on-droid,
    ...
  }: let
    systems = ["x86_64-linux" "aarch64-linux"];
    root = ./.;
    modules = "${root}/modules";
    configs = "${root}/configs";
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        inputs.ez-configs.flakeModule
      ];

      inherit systems;

      ezConfigs = {
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
      };

      perSystem = {pkgs, ...}: {
        formatter = pkgs.alejandra;
      };

      flake = {
        nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
          modules = [
            "${modules}/droid"
            "${configs}/droid"
            {
              home-manager = {
                useGlobalPkgs = true;
                config = {
                  imports = [
                    "${modules}/home"
                    "${configs}/home/droid"
                  ];
                };
                extraSpecialArgs = inputs;
              };
            }
          ];
          extraSpecialArgs = inputs;
        };
      };
    };

  inputs = {
    # Loaders
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/prerelease-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    ez-configs = {
      url = "github:ehllie/ez-configs";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };

    # Meta
    flake-compat.url = "github:edolstra/flake-compat";

    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flakeCompat.follows = "flake-compat";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Packages
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
      inputs.flake-parts.follows = "flake-parts";
      inputs.home-manager.follows = "home-manager";
    };

    getchoo = {
      url = "github:getchoo/nix-exprs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    erosanix = {
      url = "github:emmanuelrosa/erosanix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
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
}
