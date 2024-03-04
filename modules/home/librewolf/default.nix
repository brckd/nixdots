{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.librewolf;
in {
  config = mkIf cfg.enable {
    programs.librewolf = {
      settings = mkDefault {
        "webgl.disabled" = false;
      };
    };
  };
}
