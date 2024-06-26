{
  nur,
  stylix,
  erosanix,
  ...
}: {
  imports = [
    nur.nixosModules.nur
    erosanix.nixosModules.protonvpn
    stylix.nixosModules.stylix
    ./stylix
    ./locale
    ./hyprland
    ./sddm
    ./pipewire
    ./theseus
    ./steam
  ];
}
