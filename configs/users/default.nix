inputs@{ nixpkgs, home-manager, ... }:

let mkUser = let
  system = "x86_64-linux";
  pkgs = nixpkgs.legacyPackages.${system};
in module: home-manager.lib.homeManagerConfiguration {
  inherit pkgs;
  modules = [ module ];
  extraSpecialArgs = inputs;
};
in {
  bricked = mkUser ./bricked;
  john = mkUser ./john;
}
