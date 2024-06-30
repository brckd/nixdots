{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.librewolf;
in {
  config = mkIf cfg.enable {
    programs.librewolf = {
      settings = {
        "webgl.disabled" = false;
      };
    };
  };
}
