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
      systems = import inputs.systems;
      specialArgs = {inherit inputs self tree systems;};
      extraSpecialArgs = specialArgs;
      inherit (builtins) readDir filter concatMap readFileType length elem;
      inherit (lib) mapAttrsToList pipe flip hasSuffix removeSuffix last applyModuleArgsIfFunction unifyModuleSyntax setAttrByPath sublist remove optional;
    in {
      imports = [
        inputs.treefmt-nix.flakeModule
        inputs.git-hooks.flakeModule
      ];

      inherit systems;

      flake = {
        test = self.lib.dots.loaders.modules' {
          src = ./configs;
          excludedSegments = ["nixos" "droid"];
          hoistedSegments = ["home"];
        };
        lib.dots = rec {
          loaders = {
            file = src: loaders.file' {inherit src;};
            file' = {
              src,
              path ? [],
              type ? readFileType src,
            }: {
              inherit src path type;
            };
            directory = src: loaders.directory' {inherit src;};
            directory' = {
              src,
              path ? [],
            }:
              mapAttrsToList (
                name: type:
                  loaders.file' {
                    inherit type;
                    src = "${src}/${name}";
                    path = path ++ [name];
                  }
              ) (readDir src);
            tree = src: loaders.tree' {inherit src;};
            tree' = {
              src,
              path ? [],
            }:
              concatMap (
                {
                  src,
                  type,
                  path,
                } @ file:
                  if type == "directory"
                  then loaders.tree' {inherit src path;}
                  else [file]
              ) (loaders.directory' {inherit src path;});
            modules = src: loaders.modules' {inherit src;};
            modules' = {
              src,
              loader ? loaders.tree,
              onlyModules ? true,
              hoistDefault ? true,
              excludedSegments ? [],
              hoistedSegments ? [],
            }:
              pipe src (
                [loader]
                ++ optional onlyModules transformers.onlyModules
                ++ optional hoistDefault transformers.hoistDefault
                ++ [(flip pipe (map transformers.withoutSegment excludedSegments))]
                ++ [(flip pipe (map transformers.hoistSegment hoistedSegments))]
              );
          };
          transformers = {
            mapName = f: files:
              map (
                {path, ...} @ file:
                  file
                  // {
                    path = sublist 0 (length path - 1) path ++ [(f (last path))];
                  }
              )
              files;
            filterName = predicate: files: filter ({path, ...}: predicate (last path)) files;
            mapPath = f: files: map ({path, ...} @ file: file // {path = f path;}) files;
            filterPath = predicate: files: filter ({path, ...}: predicate path) files;
            withSegment = segment: transformers.filterPath (elem segment);
            withoutSegment = segment: transformers.filterPath (path: !elem segment path);
            hoistSegment = segment: transformers.mapPath (remove segment);
            hoistDefault = transformers.hoistSegment "default";
            onlyExtension = extension:
              flip pipe [
                (transformers.filterName (hasSuffix ".${extension}"))
                (transformers.mapName (removeSuffix ".${extension}"))
              ];
            onlyModules = transformers.onlyExtension "nix";
          };
          listFilesRecursive = dir:
            lib.flatten (lib.mapAttrsToList (
              name: type:
                if type == "directory"
                then lib.filesystem.listFilesRecursive (dir + "/${name}")
                else dir + "/${name}"
            ) (builtins.readDir dir));
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

          load = src: let
            recurse = flip pipe [
              ({
                src,
                path ? [],
                ...
              }:
                mapAttrsToList (name: type: {inherit name type src path;}) (readDir src))
              (map (flip pipe (map (f: self: self // f self) [
                (self: {src = "${self.src}/${self.name}";})
                (self: {name = removeSuffix ".nix" self.name;})
                (self: {
                  path =
                    if self.name == "default"
                    then self.path
                    else self.path ++ [self.name];
                })
                (self: {name = last self.path;})
              ])))
              (filter ({
                type,
                src,
                ...
              }:
                type == "directory" || hasSuffix ".nix" src))
              (concatMap (
                {
                  src,
                  path,
                  type,
                  ...
                } @ module:
                  if type == "directory"
                  then
                    recurse {
                      inherit src path;
                    }
                  else [module]
              ))
            ];
          in
            (map ({
              src,
              path,
              ...
            }: args:
              pipe (import src) [
                (module: applyModuleArgsIfFunction src module args)
                (module: unifyModuleSyntax src src module)
                ({
                    config,
                    options,
                    ...
                  } @ module:
                    module
                    // {
                      config = setAttrByPath path config;
                      options = setAttrByPath path options;
                    })
              ])) (recurse {inherit src;});
        };

        homeModules = self.lib.dots.readModules "${tree.modules}/home";
        nixosModules = self.lib.dots.readModules "${tree.modules}/nixos";
        nixOnDroidModules = self.lib.dots.readModules "${tree.modules}/droid";
      };

      perSystem = {
        config,
        system,
        pkgs,
        ...
      }: {
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

        legacyPackages = {
          homeConfigurations = lib.concatMapAttrs (
            name: module: {
              ${name} = inputs.home-manager.lib.homeManagerConfiguration {
                inherit extraSpecialArgs;
                inherit pkgs;
                modules = [module self.homeModules.default];
              };
            }
          ) (self.lib.dots.readModules "${tree.configs}/home");

          nixosConfigurations = lib.concatMapAttrs (name: module:
            {
              ${name} = lib.nixosSystem {
                inherit specialArgs;
                modules = [
                  module
                  self.nixosModules.default
                  {
                    nixpkgs.hostPlatform = system;
                  }
                ];
              };
            }
            // (lib.concatMapAttrs (homeName: home: {
              "${homeName}@${name}" = lib.nixosSystem {
                inherit specialArgs;
                modules = [
                  module
                  self.nixosModules.default
                  inputs.home-manager.nixosModules.home-manager
                  {
                    nixpkgs.hostPlatform = system;
                    home-manager = {
                      inherit extraSpecialArgs;
                      useGlobalPkgs = true;
                      useUserPackages = true;
                      users.${homeName}.imports = [home self.homeModules.default];
                    };
                  }
                ];
              };
            }) (self.lib.dots.readModules "${tree.configs}/home"))) (self.lib.dots.readModules "${tree.configs}/nixos");

          nixOnDroidConfigurations = lib.concatMapAttrs (name: module:
            {
              ${name} = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
                inherit extraSpecialArgs;
                pkgs = inputs.nixpkgs.legacyPackages.${system};
                modules = [module self.nixOnDroidModules.default];
              };
            }
            // (lib.concatMapAttrs (homeName: home: {
              "${homeName}@${name}" = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
                inherit extraSpecialArgs;
                pkgs = inputs.nixpkgs.legacyPackages.${system};
                modules = [
                  module
                  self.nixOnDroidModules.default
                  {
                    home-manager = {
                      inherit extraSpecialArgs;
                      useGlobalPkgs = true;
                      useUserPackages = true;
                      config.imports = [home self.homeModules.default];
                    };
                  }
                ];
              };
            })) (self.lib.dots.readModules "${tree.configs}/home")) (self.lib.dots.readModules "${tree.configs}/droid");
        };
      };
    });

  nixConfig = {
    extra-substituters = [
      "https://nixdots.cachix.org"
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
      "https://nix-on-droid.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nixdots.cachix.org-1:kWCfT049y6VtM5wAwMzuR3VOHkvom/53Sirq/784tYA="
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
