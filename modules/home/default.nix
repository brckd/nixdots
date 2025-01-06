{inputs, ...}: {
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  imports = with inputs; [
    nur.modules.homeManager.default
    stylix.homeManagerModules.stylix
    spicetify-nix.homeManagerModules.default
    nix-flatpak.homeManagerModules.nix-flatpak
    nixvim.homeManagerModules.nixvim
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
