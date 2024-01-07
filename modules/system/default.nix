{ nix-colors, ...}:

{
  imports = [
    nix-colors.homeManagerModules.default
    ./experimental
    ./locale
    ./hyprland
    ./pipewire
    ./protonvpn
    ./zsh
    ./git
  ];
}
