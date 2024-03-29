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
        inputs.treefmt-nix.flakeModule
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

      perSystem = {...}: {
        treefmt.config = {
          projectRootFile = "flake.nix";
          programs = {
            alejandra.enable = true;
            prettier.enable = true;
          };
        };
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
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Systems
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/prerelease-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # Flake Framework
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    ez-configs = {
      url = "github:ehllie/ez-configs";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };

    flake-compat.url = "github:edolstra/flake-compat";

    flake-utils.url = "github:numtide/flake-utils";

    # Formatter
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
      inputs.flake-utils.follows = "flake-utils";
    };

    # Scheming
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
      inputs.home-manager.follows = "home-manager";
    };

    # Programs
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
      inputs.flake-parts.follows = "flake-parts";
      inputs.pre-commit-hooks.follows = "pre-commit-hooks";
      inputs.home-manager.follows = "home-manager";
      inputs.nix-darwin.follows = "nix-darwin";
    };

    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
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

    # Assets
    wallpaper.url = "file+https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/main/misc/rainbow-cat.png";
    nixos-symbolic.url = "file+https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/white.svg";
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
