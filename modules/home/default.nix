{ nix-colors, ... }:

{ 
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;

  imports = [
    nix-colors.homeManagerModules.default
    ./zsh
    ./hyprland
    ./rofi
    ./kitty
    ./nixvim
    ./librewolf
    ./fastfetch
    ./spotify-player
    ./cava
    ./theseus
    ./vesktop
  ];
}
