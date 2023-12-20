{ config, nixpkgs, ...}:

{ 
  home.stateVersion = "23.11";
  imports = [
    ./hyprland
    ./kitty
    ./neovim
    ./librewolf
    ./fastfetch
    ./spotify-player
    ./cava
  ];
}
