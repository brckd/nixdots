{ config, nixpkgs, ...}:

{
  imports = [
    ./locale
    ./hyprland
    ./pipewire
    ./protonvpn
    ./zsh
    ./git
  ];
}
