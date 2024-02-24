inputs@{ nixpkgs, home-manager, ... }:

let mkHost = module: nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [ module ];
  specialArgs = inputs;
};
in {
  desktop = mkHost ./desktop;
  laptop = mkHost ./laptop;
}
