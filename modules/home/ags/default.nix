{
  config,
  lib,
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
  };
}
