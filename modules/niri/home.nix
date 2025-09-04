{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.programs.niri;
  jsonFormat = pkgs.formats.json {};
in {
  options.programs.niri = {
    enable = lib.mkEnableOption "Niri";
    settings = lib.mkOption {
      inherit (jsonFormat) type;
      default = {};
      description = ''
        Configuration written to
        {file}`$XDG_CONFIG_HOME/niri/config.kdl`.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    programs.niri.settings = {
      input = {
        keyboard.xkb.layout = ["de"];
        touchpad = {
          tap = [];
          natural-scroll = [];
        };
        focus-follows-mouse = [];
      };
      output = {
        _args = ["eDP-1"];
        mode = ["3840x2160@59.997"];
        scale = [1];
        variable-refresh-rate = [];
      };
      layout = {
        gaps = [10];
        default-column-width.proportion = [0.5];
        focus-ring.off = [];
        border.off = [];
      };
      hotkey-overlay = {
        skip-at-startup = [];
      };
      screenshot-path = ["~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"];
      window-rule = {
        geometry-corner-radius = [10];
        clip-to-geometry = [true];
      };
      binds = {
        "Mod+numbersign".show-hotkey-overlay = [];
        "Mod+Q".close-window = [];
        "Mod+F".expand-column-to-available-width = [];
        "Mod+Shift+F".maximize-column = [];
        "Mod+Shift+Q".quit = [];
        "Print".screenshot = [];
        "Shift+Print".screenshot-window = [];
        "Ctrl+Print".screenshot-screen = [];
        "Mod+O".toggle-overview = [];
        "Mod+H".focus-column-left = [];
        "Mod+J".focus-window-down = [];
        "Mod+K".focus-window-up = [];
        "Mod+L".focus-column-right = [];
        "Mod+WheelScrollUp".focus-column-left = [];
        "Mod+WheelScrollDown".focus-column-right = [];
        "Mod+Shift+WheelScrollUp".focus-workspace-up = [];
        "Mod+Shift+WheelScrollDown".focus-workspace-down = [];
        "Mod+Space".spawn = ["anyrun"];
        "Mod+T".spawn = ["ghostty"];
      };
    };

    xdg.configFile."niri/config.kdl" = lib.mkIf (cfg.settings != {}) {
      text = lib.hm.generators.toKDL {} cfg.settings;
    };
  };
}
