{
  nur,
  stylix,
  ags,
  ...
}: {
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  imports = [
    nur.hmModules.nur
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
    ./lf
    ./librewolf
    ./cava
    ./vesktop
  ];
}
