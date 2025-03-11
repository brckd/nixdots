{
  lib,
  self,
  system,
  ...
}: let
  inherit (lib) concatMapAttrs nixosSystem mkForce;
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
          disableNixpkgsOptionsHomeModule = {
            nixpkgs = {
              config = mkForce null;
              overlays = mkForce null;
            };
          };
          homeIntegrationModule = {
            home-manager = {
              inherit extraSpecialArgs;
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${userName}.imports = [userHomeModule hostHomeModule disableNixpkgsOptionsHomeModule];
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
