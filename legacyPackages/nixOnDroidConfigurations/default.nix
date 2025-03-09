{
  lib,
  self,
  pkgs,
  inputs,
  ...
}: let
  inherit (lib) concatMapAttrs;
  inherit (inputs.nix-on-droid.lib) nixOnDroidConfiguration;
  inherit (self.lib) tree;
  inherit (tree) modules;
  extraSpecialArgs = tree.specialArgs.mixed;
in
  concatMapAttrs (
    name: module: {
      ${name} = nixOnDroidConfiguration {
        inherit pkgs extraSpecialArgs;
        modules = [module (self.nixOnDroidModules.default or {})];
      };
    }
  )
  modules.mixed.hosts.droid
