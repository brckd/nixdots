{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.direnv;
in {
  config = mkIf cfg.enable {
    programs.direnv = {
      nix-direnv.enable = true;
    };
  };
}
