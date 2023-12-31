{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.cava;
  colors = config.colorScheme.colors;
  mkGradient = count: colors: listToAttrs (zipListsWith
    (i: color: { name = "gradient_color_${toString i}"; value = "'#${color}'"; })
    (lists.range 1 count)
    colors
  ) // { gradient = "1"; gradient_count = toString count; };
in {
  options.modules.cava = {
    enable = mkEnableOption "Enable Cava";
  };

  config = mkIf cfg.enable {
    programs.cava = {
      enable = true;

      settings = {
        input.method = "pipewire";
        color = mkGradient 7 (with colors; [
          base0E base0D base0C base0B base0A base09 base08
        ]);
      };
    };
  };
}
