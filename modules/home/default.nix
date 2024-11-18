{
  nur,
  stylix,
  spicetify-nix,
  ...
}: {
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  imports = [
    nur.hmModules.nur
    stylix.homeManagerModules.stylix
    spicetify-nix.homeManagerModules.default
    ./dconf
    ./stylix
    ./zsh
    ./starship
    ./direnv
    ./kitty
    ./nixvim
    ./vscode
    ./lf
    ./npm
    ./librewolf
    ./spicetify
  ];
}
