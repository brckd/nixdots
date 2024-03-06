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
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
      autocd = true;
    };
  };
}
