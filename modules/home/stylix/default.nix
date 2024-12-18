{
  config,
  lib,
  pkgs,
  wallpaper,
  ...
}:
with lib; let
  cfg = config.stylix;
in {
  imports = [./targets/steam ./targets/firefox ./targets/flatpak];

  config = mkIf cfg.enable {
    stylix = {
      image = wallpaper;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      override.base0C = "90c0e4"; # make teal less intense
      fonts = rec {
        sansSerif = {
          package = pkgs.lexend;
          name = "Lexend";
        };
        serif = sansSerif;
        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font Mono Regular";
        };
      };
    };
  };
}
