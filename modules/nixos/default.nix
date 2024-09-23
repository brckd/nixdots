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
    ./xserver
    ./gnome
    ./stylix
    ./locale
    ./steam
  ];
}
