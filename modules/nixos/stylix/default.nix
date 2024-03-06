{pkgs, ...}: {
  config = {
    stylix = {
      image = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/1023077979591cdeca76aae94e0359da1707a60e/misc/rainbow-cat.png";
        hash = "sha256-WP+kQ7mgjpeekatDEPSP/XeDc5ZihCm+BxgqgwYDIEU=";
      };
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      fonts = rec {
        monospace = {
          package = pkgs.jetbrains-mono;
          name = "JetBrains Mono";
        };
        serif = monospace;
        sansSerif = monospace;
        emoji = monospace;
      };
    };
  };
}
