{
  lib,
  self,
  system,
  ...
}: let
  inherit (lib) concatMapAttrs nixosSystem;
  inherit (self.lib) tree;
  specialArgs = tree.specialArgs.mixed;
in
  concatMapAttrs (
    name: module: {
      ${name} = nixosSystem {
        inherit system specialArgs;
        modules = [module (self.nixosModules.default or {})];
      };
    }
  )
  tree.modules.mixed.hosts.nixos
