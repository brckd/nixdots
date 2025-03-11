{
  lib,
  self,
  system,
  ...
}: let
  inherit (lib) concatMapAttrs nixosSystem;
  inherit (self.lib) tree;
  inherit (tree) modules;
  specialArgs = tree.specialArgs.mixed;
  extraSpecialArgs = specialArgs;
in
  concatMapAttrs (
    hostName: hostModule:
      {
        ${hostName} = nixosSystem {
          inherit system specialArgs;
          modules = [hostModule];
        };
      }
      // concatMapAttrs (
        userName: userHomeModule: let
          hostHomeModule = modules.mixed.hosts.home.${userName} or {};
          homeIntegrationModule = {
            home-manager = {
              inherit extraSpecialArgs;
              users.${userName}.imports = [userHomeModule hostHomeModule];
            };
          };
        in {
          "${userName}@${hostName}" = nixosSystem {
            inherit system specialArgs;
            modules = [hostModule homeIntegrationModule];
          };
        }
      )
      modules.mixed.users.home
  )
  modules.mixed.hosts.nixos
