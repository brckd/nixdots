{
  lib,
  self,
  system,
  ...
}: let
  inherit (lib) concatMapAttrs;
  inherit (self.lib) tree;
  specialArgs = tree.specialArgs.mixed;
in
  concatMapAttrs (
    name: module: {
      ${name} = lib.nixosSystem {
        inherit system specialArgs;
        modules = [module (self.nixosModules.default or {})];
      };
    }
  )
  tree.modules.mixed.hosts.nixos
