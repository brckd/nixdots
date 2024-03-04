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
      package = mkDefault pkgs.rofi-wayland;
      plugins = with pkgs; mkDefault [rofi-power-menu rofi-screenshot rofimoji rofi-calc];
      extraConfig = mkDefault {
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
        mkDefault {
          "*" = with palette; {
            bg-col = mkLiteral "#${base00}";
            bg-col-light = mkLiteral "#${base00}";
            border-col = mkLiteral "#${base00}";
            selected-col = mkLiteral "#${base00}";
            blue = mkLiteral "#${base0D}";
            fg-col = mkLiteral "#${base05}";
            fg-col2 = mkLiteral "#${base08}";
            grey = mkLiteral "#${base03}";

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
            border-color = mkLiteral "@border-col";
            background-color = mkLiteral "@bg-col";
          };

          "mainbox" = {
            background-color = mkLiteral "@bg-col";
          };

          "inputbar" = {
            children = mkLiteral "[prompt,entry]";
            background-color = mkLiteral "@bg-col";
            border-radius = mkLiteral "10px";
            padding = mkLiteral "2px";
          };

          "prompt" = {
            background-color = mkLiteral "@blue";
            padding = mkLiteral "6px";
            text-color = mkLiteral "@bg-col";
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
            text-color = mkLiteral "@fg-col";
            background-color = mkLiteral "@bg-col";
          };

          "listview" = {
            border = mkLiteral "0px 0px 0px";
            padding = mkLiteral "6px 0px 0px";
            margin = mkLiteral "10px 0px 0px 20px";
            columns = mkLiteral "2";
            lines = mkLiteral "5";
            background-color = mkLiteral "@bg-col";
          };

          "element" = {
            padding = mkLiteral "10px";
            background-color = mkLiteral "@bg-col";
            text-color = mkLiteral "@fg-col  ";
          };

          "element-icon" = {
            size = mkLiteral "25px";
          };

          "element selected" = {
            background-color = mkLiteral "@selected-col";
            text-color = mkLiteral "@fg-col2";
          };

          "mode-switcher" = {
            spacing = mkLiteral "0";
          };

          "button" = {
            padding = mkLiteral "10px";
            background-color = mkLiteral "@bg-col-light";
            text-color = mkLiteral "@grey";
            vertical-align = mkLiteral "0.5";
            horizontal-align = mkLiteral "0.5";
          };

          "button selected" = {
            background-color = mkLiteral "@bg-col";
            text-color = mkLiteral "@blue";
          };

          "message" = {
            background-color = mkLiteral "@bg-col-light";
            margin = mkLiteral "2px";
            padding = mkLiteral "2px";
            border-radius = mkLiteral "10px";
          };

          "textbox" = {
            padding = mkLiteral "6px";
            margin = mkLiteral "20px 0px 0px 20px";
            text-color = mkLiteral "@blue";
            background-color = mkLiteral "@bg-col-light";
          };
        };
    };

    wayland.windowManager.hyprland.settings.bind = with cfg.keybind;
      mkIf enable (mkDefault ["${modkey}, ${key}, exec, ${command}"]);
  };
}
