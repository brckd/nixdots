{stylix, ...}: {
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;

  imports = [
    stylix.homeManagerModules.stylix
    ./stylix
    ./zsh
    ./hyprland
    ./wpaperd
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
