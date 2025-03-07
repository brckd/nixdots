{
  lib,
  self,
  inputs,
  pkgs,
  ...
}: let
  inherit (lib) concatMapAttrs;
  inherit (self.lib.tree.paths.combined) configs;
in
  concatMapAttrs (
    name: module: {
      ${name} = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [module self.homeModules.default];
      };
    }
  ) (configs.home // configs.common)
