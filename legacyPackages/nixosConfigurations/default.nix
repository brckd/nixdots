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
        userName: homeUserModule: let
          homeHostModule = modules.mixed.hosts.home.${userName} or {};
          homeIntegrationModule = {
            home-manager = {
              inherit extraSpecialArgs;
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${userName}.imports = [homeUserModule homeHostModule];
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
