{
  nur,
  stylix,
  disko,
  lanzaboote,
  nix-flatpak,
  ...
}: {
  imports = [
    nur.modules.nixos.default
    stylix.nixosModules.stylix
    disko.nixosModules.disko
    lanzaboote.nixosModules.lanzaboote
    nix-flatpak.nixosModules.nix-flatpak
    ./boot
    ./xserver
    ./gnome
    ./nautilus
    ./stylix
    ./locale
    ./steam
  ];
}
