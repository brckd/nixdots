{
  description = "NixOS configuration";

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} ({
      lib,
      self,
      ...
    }: let
      inherit (tree) paths evalAll modules;

      systems = import inputs.systems;
      tree = import ./lib/tree/default.nix {inherit lib self inputs systems;};
    in {
      imports = [
        inputs.treefmt-nix.flakeModule
        inputs.git-hooks.flakeModule
      ];

      inherit systems;

      flake = {
        inherit (modules.generic) lib templates;
        homeModules = modules.mixed.modules.home;
        nixosModules = paths.mixed.modules.nixos;
        nixOnDroidModules = paths.mixed.modules.droid;
      };

      perSystem = {
        config,
        options,
        pkgs,
        system,
        ...
      }: let
        specialArgs.generic' = tree.specialArgs.generic // {inherit config options pkgs system;};
        modules.generic' = evalAll.generic specialArgs.generic' paths.generic;
      in {
        inherit (modules.generic') checks apps packages legacyPackages devShells;

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
      };
    });

  nixConfig = {
    extra-substituters = [
      "https://nixdots.cachix.org"
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://nix-on-droid.cachix.org"
      "https://pre-commit-hooks.cachix.org"
      "https://statix.cachix.org"
      "https://om.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nixdots.cachix.org-1:kWCfT049y6VtM5wAwMzuR3VOHkvom/53Sirq/784tYA="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nix-on-droid.cachix.org-1:56snoMJTXmDRC1Ei24CmKoUqvHJ9XCp+nidK7qkMQrU="
      "pre-commit-hooks.cachix.org-1:Pkk3Panw5AW24TOv6kz3PvLhlH8puAsJTBbOPmBo7Rc="
      "statix.cachix.org-1:Z9E/g1YjCjU117QOOt07OjhljCoRZddiAm4VVESvais="
      "om.cachix.org-1:ifal/RLZJKN4sbpScyPGqJ2+appCslzu7ZZF/C01f2Q="
    ];
  };

  inputs = {
    # Package reposities
    nixpkgs.url = "github:brckd/nixpkgs/nixos-unstable";
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

    systems.url = "github:nix-systems/default-linux";

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

    nix-data = {
      url = "github:snowfallorg/nix-data";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-fast-build = {
      url = "github:brckd/nix-fast-build";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
      inputs.treefmt-nix.follows = "treefmt-nix";
    };

    omnix = {
      url = "github:juspay/omnix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
      inputs.systems.follows = "systems";
      inputs.git-hooks.follows = "git-hooks";
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
      inputs.firefox-gnome-theme.follows = "firefox-gnome-theme";
      inputs.nur.follows = "nur";
    };

    apple-fonts = {
      url = "github:lyndeno/apple-fonts.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    whitesur-wallpapers = {
      url = "github:vinceliuice/whitesur-wallpapers";
      flake = false;
    };

    orchis-theme = {
      url = "github:vinceliuice/orchis-theme";
      flake = false;
    };

    # Programs
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.systems.follows = "systems";
    };

    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-software-center = {
      url = "github:ljubitje/nix-software-center";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "flake-utils";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Boot
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
      inputs.flake-parts.follows = "flake-parts";
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
