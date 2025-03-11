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
    hostName: hostModule:
      {
        ${hostName} = nixOnDroidConfiguration {
          inherit pkgs extraSpecialArgs;
          modules = [hostModule];
        };
      }
      // concatMapAttrs (
        userName: userHomeModule: let
          hostHomeModule = modules.mixed.hosts.home.${userName} or {};
          homeIntegrationModule = {
            home-manager = {
              inherit extraSpecialArgs;
              config.imports = [userHomeModule hostHomeModule];
            };
          };
        in {
          "${userName}@${hostName}" = nixOnDroidConfiguration {
            inherit pkgs extraSpecialArgs;
            modules = [hostModule homeIntegrationModule];
          };
        }
      )
      modules.mixed.users.home
  )
  modules.mixed.hosts.droid
