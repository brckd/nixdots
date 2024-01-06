{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.cava;
in {
  options.modules.cava = {
    enable = mkEnableOption "Enable Cava";
  };

  config = mkIf cfg.enable {
    programs.cava = {
      enable = true;

      settings = {
        input.method = "pipewire";
        color = {
          gradient = "1";
          gradient_count = "8";
          gradient_color_1 = "'#b4befe'";
          gradient_color_2 = "'#89b4fa'";
          gradient_color_3 = "'#89dceb'";
          gradient_color_4 = "'#a6e3a1'";
          gradient_color_5 = "'#f9e2af'";
          gradient_color_6 = "'#fab387'";
          gradient_color_7 = "'#eba0ac'";
          gradient_color_8 = "'#f38ba8'";
        };
      };
    };
  };
}
