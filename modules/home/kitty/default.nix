{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.kitty;
in {
  config = mkIf cfg.enable {
    programs.kitty = {
      shellIntegration.enableZshIntegration = true;

      settings = {
        single_window_padding_width = 10;
        linux_display_server = "x11"; # Fixes header bar on gnome
      };

      keybindings = {
        "ctrl+shift+alt+c" = "copy_ansi_to_clipboard";
      };
    };
  };
}
