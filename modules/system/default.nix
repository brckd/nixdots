{ config, nixpkgs, ...}:

{
  imports = [
    ./experimental
    ./locale
    ./hyprland
    ./pipewire
    ./protonvpn
    ./zsh
    ./git
  ];
}
