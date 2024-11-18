{
  nur,
  stylix,
  disko,
  ...
}: {
  imports = [
    nur.nixosModules.nur
    stylix.nixosModules.stylix
    disko.nixosModules.disko
    ./boot
    ./xserver
    ./gnome
    ./nautilus
    ./stylix
    ./locale
    ./steam
  ];
}
