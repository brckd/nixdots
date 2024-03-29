{
  pkgs,
  wallpaper,
  ...
}: {
  config = {
    stylix = {
      # placeholder
      image = wallpaper;

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
