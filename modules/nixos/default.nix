{
  nur,
  stylix,
  ...
}: {
  imports = [
    nur.nixosModules.nur
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
