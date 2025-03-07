{lib, ...}: let
  inherit (builtins) readDir mapAttrs;
  inherit (lib) pathIsDirectory pathIsRegularFile filterAttrs genAttrs id concatMapAttrs;
  inherit (lib.path) append;
in rec {
  dirs = {
    root = ../..;
    generic = genAttrs ["lib" "overlays" "checks" "apps" "packages" "legacyPackages" "devShells" "templates"] (append dirs.root);
    combined = genAttrs ["modules" "hosts" "users"] (append dirs.root);
  };

  classes = genAttrs ["home" "nixos" "droid" "common"] id;

  load = {
    dir = path:
      if pathIsDirectory path
      then concatMapAttrs (name: type: {${name} = append path name;}) (readDir path)
      else {};
    combined = class: path: filterAttrs (name: pathIsRegularFile) (mapAttrs (name: path: append path "${class}.nix") (load.dir path));
    generic = load.combined "default";
  };

  paths = {
    generic = mapAttrs (name: load.generic) dirs.generic;
    combined = mapAttrs (name: path: mapAttrs (_: class: load.combined class path) classes) dirs.combined;
  };
}
