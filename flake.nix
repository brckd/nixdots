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
        inputs.pre-commit-hooks.flakeModule
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

      perSystem = {
        config,
        pkgs,
        ...
      }: {
        treefmt.config = {
          projectRootFile = "flake.nix";
          programs = {
            alejandra.enable = true;
            prettier.enable = true;
          };
          flakeCheck = false;
        };

        pre-commit.settings = {
          hooks.treefmt.enable = true;
        };

        devShells.default = config.pre-commit.devShell;
      };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    # Systems
    home-manager = {
      url = "github:brckd/home-manager";
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

    # Development

    flake-compat.url = "github:edolstra/flake-compat";

    flake-utils.url = "github:numtide/flake-utils";

    gitignore = {
      url = "github:hercules-ci/gitignore";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.flake-compat.follows = "flake-compat";
      inputs.gitignore.follows = "gitignore";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    # Formatter
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
      inputs.gitignore.follows = "gitignore";
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
      inputs.home-manager.follows = "home-manager";
      inputs.nix-darwin.follows = "nix-darwin";
      inputs.treefmt-nix.follows = "treefmt-nix";
      inputs.devshell.follows = "devshell";
      inputs.git-hooks.follows = "git-hooks";
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
    wallpaper = {
      url = "file+https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/1023077979591cdeca76aae94e0359da1707a60e/minimalistic/blue-cat.png";
      flake = false;
    };
    nixos-symbolic = {
      url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/de03e887f03037e7e781a678b57fdae603c9ca20/logo/nix-snowflake-white.svg";
      flake = false;
    };
  };
}
