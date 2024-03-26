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
      };
    };
  };
}
