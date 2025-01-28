{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.zsh;
in {
  config = mkIf cfg.enable {
    programs.zsh = {
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      history.ignoreSpace = true;
    };
  };
}
