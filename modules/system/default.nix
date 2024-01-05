{ config, nixpkgs, ...}:

{
  imports = [
    ./hardware
    ./locale
    ./hyprland
    ./pipewire
    ./zsh
    ./git
  ];
}
