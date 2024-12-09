{
  nur,
  stylix,
  spicetify-nix,
  nix-flatpak,
  ...
}: {
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  imports = [
    nur.modules.homeManager.default
    stylix.homeManagerModules.stylix
    spicetify-nix.homeManagerModules.default
    nix-flatpak.homeManagerModules.nix-flatpak
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
