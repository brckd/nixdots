{
  stylix,
  erosanix,
  ...
}: {
  imports = [
    erosanix.nixosModules.protonvpn
    stylix.nixosModules.stylix
    ./stylix
    ./experimental
    ./locale
    ./hyprland
    ./sddm
    ./pipewire
    ./steam
  ];
}
