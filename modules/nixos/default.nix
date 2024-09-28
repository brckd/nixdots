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
    ./boot
    ./xserver
    ./gnome
    ./nautilus
    ./stylix
    ./locale
    ./steam
  ];
}
