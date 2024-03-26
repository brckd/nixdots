{
  stylix,
  erosanix,
  ...
}: {
  imports = [
    erosanix.nixosModules.protonvpn
    stylix.nixosModules.stylix
    ./stylix
    ./locale
    ./hyprland
    ./sddm
    ./pipewire
    ./steam
  ];
}
