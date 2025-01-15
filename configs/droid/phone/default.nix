{
  pkgs,
  config,
  lib,
  ...
}: {
  system.stateVersion = "24.05";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  environment.packages = with pkgs; [zsh git];

  user.shell = "${pkgs.zsh}/bin/zsh";
  terminal = lib.mkIf (config ? home-manager.config.stylix) {
    # Stolen from https://github.com/mk12/base16-kitty/blob/main/templates/default.mustache
    colors = with config.home-manager.config.lib.stylix.colors.withHashtag; {
      background = base00;
      foreground = base05;
      cursor = base0D;

      # Normal
      color0 = base00;
      color1 = base08;
      color2 = base0B;
      color3 = base0A;
      color4 = base0D;
      color5 = base0E;
      color6 = base0C;
      color7 = base05;

      # Bright
      color8 = base03;
      color9 = base08;
      color10 = base0B;
      color11 = base0A;
      color12 = base0D;
      color13 = base0E;
      color14 = base0C;
      color15 = base07;
    };
    font = let
      font = config.home-manager.config.stylix.fonts.monospace;
      inherit (font) package;
      identifiers = lib.splitString " " font.name;
      name = builtins.head identifiers;
      variant = lib.last identifiers;
    in "${package}/share/fonts/truetype/NerdFonts/${name}/${name}NerdFont-${variant}.ttf";
  };
}
