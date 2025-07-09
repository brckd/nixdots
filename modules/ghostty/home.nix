{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.ghostty;
in {
  config = mkIf cfg.enable {
    programs.ghostty.settings = {
      window-padding-x = 10;
      window-padding-y = 10;
    };
  };
}
