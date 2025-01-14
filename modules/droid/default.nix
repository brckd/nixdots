{inputs, ...}: {
  imports = with inputs; [
    stylix.nixosModules.stylix
    ./stylix
  ];
}
