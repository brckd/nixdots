{ nix-colors, ... }:

{ 
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;

  imports = [
    ./zsh
    ./neovim
    ./fastfetch
  ];
}
