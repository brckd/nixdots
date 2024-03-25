{pkgs, ...}: {
  config = {
    stylix = {
      # placeholder
      image = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/1023077979591cdeca76aae94e0359da1707a60e/misc/rainbow-cat.png";
        hash = "sha256-WP+kQ7mgjpeekatDEPSP/XeDc5ZihCm+BxgqgwYDIEU=";
      };

      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
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
    };
  };
}
