{ nix-colors, ... }:

{ 
  home.stateVersion = "23.11";
  imports = [
    nix-colors.homeManagerModules.default
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
