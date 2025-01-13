{inputs, ...}: {
  imports = with inputs; [
    nur.modules.nixos.default
    stylix.nixosModules.stylix
    disko.nixosModules.disko
    lanzaboote.nixosModules.lanzaboote
    nix-flatpak.nixosModules.nix-flatpak
    nixos-generators.nixosModules.all-formats
    ./boot
    ./xserver
    ./gnome
    ./nautilus
    ./stylix
    ./locale
    ./steam
  ];
}
