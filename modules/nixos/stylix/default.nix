{
  config,
  lib,
  pkgs,
  wallpaper,
  nixos-symbolic,
  ...
}:
with lib; let
  cfg = config.stylix;
in {
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
        monospace = let
          font = "JetBrainsMono";
        in {
          package = with pkgs; nerdfonts.override {fonts = [font];};
          name = "${font} Nerd Font Mono";
        };
        emoji = {
          package = pkgs.twemoji-color-font;
          name = "Twitter Color Emoji";
        };
      };
      targets.plymouth = {
        logo = nixos-symbolic;
        logoAnimated = true;
      };
    };
  };
}
