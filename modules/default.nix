{ config, nixpkgs, ...}:

{ 
  home.stateVersion = "23.11";
  imports = [
    ./zsh
    ./starship
    ./hyprland
    ./kitty
    ./neovim
    ./librewolf
    ./fastfetch
    ./spotify-player
    ./cava
  ];
}
