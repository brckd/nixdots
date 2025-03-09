{
  lib,
  self,
  inputs,
  pkgs,
  ...
}: let
  inherit (lib) concatMapAttrs;
  inherit (inputs.home-manager.lib) homeManagerConfiguration;
  inherit (self.lib) tree;
  inherit (tree) modules;
  extraSpecialArgs = tree.specialArgs.mixed;
in
  concatMapAttrs (
    userName: userModule:
      {
        ${userName} = homeManagerConfiguration {
          inherit pkgs extraSpecialArgs;
          modules = [userModule];
        };
      }
      // concatMapAttrs (hostName: hostModule: {
        "${userName}@${hostName}" = homeManagerConfiguration {
          inherit pkgs extraSpecialArgs;
          modules = [userModule hostModule];
        };
      })
      modules.mixed.hosts.home
  )
  modules.mixed.users.home
