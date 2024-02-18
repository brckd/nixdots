{ nix-colors, ... }:

{ 
  home.stateVersion = "23.11";
  imports = [
    nix-colors.homeManagerModules.default
    ./zsh
    ./hyprland
    ./rofi
    ./kitty
    ./neovim
    ./librewolf
    ./fastfetch
    ./spotify-player
    ./cava
    ./theseus
    ./vesktop
  ];
}
