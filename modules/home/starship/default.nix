{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.starship;
in {
  config = mkIf cfg.enable {
    programs.starship = {
      settings = {
        git_branch.symbol = " ";
      };
    };
  };
}
