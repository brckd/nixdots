inputs@{ nixpkgs, home-manager, ... }:

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
        extraSpecialArgs = inputs;
      };
    }
  ];
  specialArgs = inputs;
};
in
{
  desktop = mkHost ./desktop;
}
