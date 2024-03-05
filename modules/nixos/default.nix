{
  nix-colors,
  erosanix,
  ...
}: {
  imports = [
    nix-colors.homeManagerModules.default
    erosanix.nixosModules.protonvpn
    ./experimental
    ./locale
    ./hyprland
    ./sddm
    ./pipewire
    ./steam
  ];
}
