{
  lib,
  self,
  system,
  ...
}: let
  inherit (lib) concatMapAttrs;
  inherit (self.lib) tree;
  inherit (tree) modules;
  specialArgs = tree.specialArgs.mixed;
in
  concatMapAttrs (
    name: module: {
      ${name} = lib.nixosSystem {
        inherit system specialArgs;
        modules = [module (self.nixOnDroidModules.default or {})];
      };
    }
  )
  modules.mixed.hosts.droid
