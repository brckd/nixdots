{ config, nixpkgs, ...}:

{
  imports = [
    ./locale
    ./hyprland
    ./pipewire
    ./zsh
    ./git
  ];
}
