{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.kitty;
in {
  config = mkIf cfg.enable {
    programs.kitty = {
      shellIntegration.enableZshIntegration = mkDefault true;
      theme = mkDefault (replaceStrings [" "] ["-"] config.colorScheme.name);

      font = mkDefault {
        package = pkgs.jetbrains-mono;
        name = "JetBrains Mono";
      };

      settings = mkDefault {
        single_window_padding_width = 10;
      };
    };
  };
}
