{
  config,
  lib,
	pkgs,
  ...
}:
with lib; let
  cfg = config.programs.ags;
  colors = config.lib.stylix.colors;
	colorNames = (map (n: "base${fixedWidthNumber 2 n}") (range 0 16));
in {
  config = mkIf cfg.enable {
    programs.ags = {
      configDir = ./.;
    };
		xdg.configFile."ags".recursive = true;

    xdg.configFile."ags/src/style/colors.css".text =
      concatMapStringsSep "\n"
      (color: "@define-color ${color} ${colors.withHashtag.${color}};")
			colorNames;

		xdg.configFile."ags/src/assets/nixos-symbolic.svg".source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/35ebbbf01c3119005ed180726c388a01d4d1100c/logo/white.svg";
        hash = "sha256-Ed2l6i2wi/YTcWCq23bspH/t3RYp6AodykpXF1Zgccw=";
		};
  };
}
