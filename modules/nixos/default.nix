{
  nur,
  stylix,
  disko,
  lanzaboote,
  ...
}: {
  imports = [
    nur.nixosModules.nur
    stylix.nixosModules.stylix
    disko.nixosModules.disko
    lanzaboote.nixosModules.lanzaboote
    ./boot
    ./xserver
    ./gnome
    ./nautilus
    ./stylix
    ./locale
    ./steam
  ];
}
