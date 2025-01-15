{
  description = "NixOS configuration";

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} ({
      lib,
      self,
      ...
    }: let
      tree = rec {
        root = ./.;
        modules = "${root}/modules";
        configs = "${root}/configs";
        checks = "${root}/checks";
        packages = "${root}/packages";
        apps = "${root}/apps";
      };
      systems = ["x86_64-linux" "aarch64-linux"];
      hosts = self.nixosConfigurations // self.nixOnDroidConfigurations;
      specialArgs = {inherit inputs self tree;};
      extraSpecialArgs = specialArgs;
    in {
      imports = [
        inputs.treefmt-nix.flakeModule
        inputs.git-hooks.flakeModule
      ];

      inherit systems;

      flake = {
        lib.dots = {
          readModules = path:
            if builtins.pathExists path
            then
              lib.concatMapAttrs (
                item: type:
                  if type == "directory"
                  then {${item} = "${path}/${item}";}
                  else {${lib.removeSuffix ".nix" item} = "${path}/${item}";}
              ) (builtins.readDir path)
            else {};
        };

        homeModules = self.lib.dots.readModules "${tree.modules}/home";
        homeConfigurations = lib.concatMapAttrs (name: module:
          lib.concatMapAttrs (
            hostName: host: {
              "${name}@${hostName}" = inputs.home-manager.lib.homeManagerConfiguration {
                inherit extraSpecialArgs;
                inherit (host) pkgs;
                modules = [module self.homeModules.default];
              };
            }
          )
          hosts) (self.lib.dots.readModules "${tree.configs}/home");

        nixosModules = self.lib.dots.readModules "${tree.modules}/nixos";
        nixosConfigurations = lib.mapAttrs (name: module:
          lib.nixosSystem {
            inherit specialArgs;
            modules = [module self.nixosModules.default];
          }) (self.lib.dots.readModules "${tree.configs}/nixos");

        nixOnDroidModules = self.lib.dots.readModules "${tree.modules}/droid";
        nixOnDroidConfigurations = lib.mapAttrs (name: module:
          inputs.nix-on-droid.lib.nixOnDroidConfiguration {
            inherit extraSpecialArgs;
            pkgs = inputs.nixpkgs.legacyPackages."aarch64-linux";
            modules = [module self.nixOnDroidModules.default];
          }) (self.lib.dots.readModules "${tree.configs}/droid");
      };

      perSystem = {config, ...}: {
        treefmt.config = {
          projectRootFile = "flake.nix";
          programs = {
            statix.enable = true;
            alejandra.enable = true;
            prettier.enable = true;
            actionlint.enable = true;
          };
          flakeCheck = false;
        };

        pre-commit.settings = {
          hooks.treefmt.enable = true;
        };

        devShells = {
          default = config.pre-commit.devShell;
        };

        checks = self.lib.dots.readModules tree.checks;
        packages = self.lib.dots.readModules tree.packages;
        apps = self.lib.dots.readModules tree.apps;
      };
    });

  nixConfig = {
    substituters = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
      "https://nix-on-droid.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nix-on-droid.cachix.org-1:56snoMJTXmDRC1Ei24CmKoUqvHJ9XCp+nidK7qkMQrU="
    ];
  };

  inputs = {
    # Package reposities
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nur = {
      url = "github:nix-community/NUR";
      inputs.flake-parts.follows = "flake-parts";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.treefmt-nix.follows = "treefmt-nix";
    };

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
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-for-bootstrap.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Flake Framework
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    # Development
    flake-compat.url = "github:edolstra/flake-compat";

    systems.url = "github:nix-systems/default";

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

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
    };

    # Formatter
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Theming
    stylix = {
      url = "github:brckd/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
      inputs.flake-utils.follows = "flake-utils";
      inputs.git-hooks.follows = "git-hooks";
      inputs.systems.follows = "systems";
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

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
    };

    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
      inputs.flake-utils.follows = "flake-utils";
    };

    nix-software-center = {
      url = "github:ljubitje/nix-software-center";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "flake-utils";
    };

    # Boot
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
      inputs.flake-parts.follows = "flake-parts";
      inputs.flake-utils.follows = "flake-utils";
      inputs.pre-commit-hooks-nix.follows = "git-hooks";
    };

    # Assets
    wallpapers = {
      url = "github:orangci/walls-catppuccin-mocha";
      flake = false;
    };

    spicetify-waveform-extension = {
      url = "github:spotlab-live/spicetify-waveform";
      flake = false;
    };

    firefox-gnome-theme = {
      url = "github:rafaelmardojai/firefox-gnome-theme";
      flake = false;
    };
  };
}
