{ nix-colors, ...}:

{
  imports = [
    nix-colors.homeManagerModules.default
    ./experimental
    ./locale
    ./hyprland
    ./sddm
    ./pipewire
    ./protonvpn
    ./zsh
    ./git
  ];
}
