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
        userName: homeUserModule: let
          homeHostModule = modules.mixed.hosts.home.${userName} or {};
          homeIntegrationModule = {
            home-manager = {
              inherit extraSpecialArgs;
              useGlobalPkgs = true;
              useUserPackages = true;
              config.imports = [homeUserModule homeHostModule];
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
