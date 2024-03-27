{
  stylix,
  ags,
  ...
}: {
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;

  imports = [
    stylix.homeManagerModules.stylix
    ags.homeManagerModules.default
    ./stylix
    ./zsh
    ./hyprland
    ./wpaperd
    ./ags
    ./rofi
    ./kitty
    ./nixvim
    ./bun
    ./librewolf
    ./fastfetch
    ./spotify-player
    ./cava
    ./theseus
    ./vesktop
  ];
}
