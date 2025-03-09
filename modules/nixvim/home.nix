{inputs, ...}: {
  imports = [
    ./common.nix
    inputs.nixvim.homeManagerModules.nixvim
  ];
}
