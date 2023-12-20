{ config, pkgs, lib, ... }:

with lib; {
  options.modules.kitty = {enable = mkEnableOption "kitty"; };

  config = mkIf config.modules.kitty.enable {
    programs.kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = true;

      font = {
        package = pkgs.jetbrains-mono;
        name = "JetBrains Mono";
      };
    };
  };
}
