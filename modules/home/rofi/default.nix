{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.rofi;
  palette = config.colorScheme.palette;
in {
  options.programs.rofi = {
    keybind = {
      enable = mkEnableOption "Whether to launch Rofi on Hyprland using a keybind.";
      modkey = mkOption {
        default = "SUPER";
        type = types.str;
      };
      key = mkOption {
        default = "space";
        type = types.str;
      };
      command = mkOption {
        default = "rofi -show drun";
        type = types.str;
      };
    };
  };

  config = mkIf cfg.enable {
    programs.rofi = {
      package = pkgs.rofi-wayland;
      plugins = with pkgs; [rofi-power-menu rofi-screenshot rofimoji rofi-calc];
      extraConfig = {
        modi = "run,drun,window";
        icon-theme = "Oranchelo";
        show-icons = true;
        terminal = mkIf config.programs.kitty.enable "kitty";
        drun-display-format = "{icon} {name}";
        location = 0;
        disable-history = false;
        hide-scrollbar = true;
        sidebar-mode = true;
      };
      theme = let
        inherit (config.lib.formats.rasi) mkLiteral;
      in
        {
          "*" = {
            width = 600;
          };

          "element-text, element-icon , mode-switcher" = {
            background-color = mkLiteral "inherit";
            text-color = mkLiteral "inherit";
          };

          "window" = {
            height = mkLiteral "360px";
            border = mkLiteral "3px";
            border-radius = mkLiteral "5px";
          };

          "inputbar" = {
            children = mkLiteral "[prompt,entry]";
            border-radius = mkLiteral "10px";
            padding = mkLiteral "2px";
          };

          "prompt" = {
            padding = mkLiteral "6px";
            border-radius = mkLiteral "3px";
            margin = mkLiteral "20px 0px 0px 20px";
          };

          "textbox-prompt-colon" = {
            expand = mkLiteral "false";
            str = ":";
          };

          "entry" = {
            padding = mkLiteral "6px";
            margin = mkLiteral "20px 0px 0px 10px";
          };

          "listview" = {
            border = mkLiteral "0px 0px 0px";
            padding = mkLiteral "6px 0px 0px";
            margin = mkLiteral "10px 20px 0px 20px";
						lines = mkLiteral "5";
          };

          "element" = {
            padding = mkLiteral "10px";
            border-radius = mkLiteral "5px";
          };

          "element-icon" = {
            size = mkLiteral "25px";
          };

          "mode-switcher" = {
            spacing = mkLiteral "0";
          };

          "button" = {
            padding = mkLiteral "10px";
            vertical-align = mkLiteral "0.5";
            horizontal-align = mkLiteral "0.5";
            border-radius = mkLiteral "5px 5px 0px 0px";
          };

          "message" = {
            margin = mkLiteral "2px";
            padding = mkLiteral "2px";
            border-radius = mkLiteral "10px";
          };

          "textbox" = {
            padding = mkLiteral "6px";
            margin = mkLiteral "20px 0px 0px 20px";
          };
        };
    };

    wayland.windowManager.hyprland.settings.bind = with cfg.keybind;
      mkIf enable ["${modkey}, ${key}, exec, ${command}"];
  };
}
