{
  lib,
  inputs,
  self,
  systems,
  ...
}: let
  inherit (builtins) readDir mapAttrs;
  inherit (lib) pathIsDirectory pathIsRegularFile filterAttrs genAttrs id concatMapAttrs isPath isFunction;
  inherit (lib.path) append;
in rec {
  dirs = {
    root = ../..;
    generic = genAttrs ["lib" "overlays" "checks" "apps" "packages" "legacyPackages" "devShells" "templates"] (append dirs.root);
    mixed = genAttrs ["modules" "hosts" "users"] (append dirs.root);
  };

  classes = genAttrs ["home" "nixos" "droid"] id;

  load = {
    dir = path:
      if pathIsDirectory path
      then concatMapAttrs (name: type: {${name} = append path name;}) (readDir path)
      else {};
    mixed = class: path: filterAttrs (name: pathIsRegularFile) (mapAttrs (name: path: append path "${class}.nix") (load.dir path));
    generic = load.mixed "default";
  };

  paths = {
    generic = mapAttrs (type: load.generic) dirs.generic;
    mixed = mapAttrs (type: path: mapAttrs (_: class: load.mixed class path) classes) dirs.mixed;
  };

  specialArgs = {
    mixed = {inherit inputs self systems;};
    generic = specialArgs.mixed // {inherit lib;};
  };

  eval.generic = specialArgs: module: let
    imported =
      if isPath module
      then import module
      else module;
    loaded =
      if isFunction imported
      then imported specialArgs
      else imported;
  in
    loaded;

  evalAll.generic = args: mapAttrs (name: mapAttrs (name: eval.generic args));

  modules = {
    generic = evalAll.generic specialArgs.generic paths.generic;
    inherit (paths) mixed;
  };
}
