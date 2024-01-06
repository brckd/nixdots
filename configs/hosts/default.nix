{ nixpkgs, home-manager, nix-colors, ... }:

let mkHost = path: nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    path
    home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users = import ../users;
        extraSpecialArgs = { inherit nix-colors; };
      };
    }
  ];
  specialArgs = { inherit nix-colors; };
};
in
{
  desktop = mkHost ./desktop;
}
