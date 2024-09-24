{
  nur,
  stylix,
  ...
}: {
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  imports = [
    nur.hmModules.nur
    stylix.homeManagerModules.stylix
    ./dconf
    ./stylix
    ./zsh
    ./starship
    ./kitty
    ./nixvim
    ./lf
    ./librewolf
    ./cava
    ./vesktop
    ./heroic
  ];
}
