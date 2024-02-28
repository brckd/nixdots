{ nix-colors, ... }:

{ 
  home.stateVersion = "23.05";
  programs.home-manager.enable = true;

  imports = [
    ./zsh
    ./neovim
    ./fastfetch
  ];
}
