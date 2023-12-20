{ config, pkgs, lib, ... }:

with lib; {
  options.modules.kitty = {enable = mkEnableOption "kitty"; };

  config = mkIf config.modules.kitty.enable {
    programs.kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = config.modules.zsh.enable;
      theme = "Catppuccin-Mocha";

      font = {
        package = pkgs.jetbrains-mono;
        name = "JetBrains Mono";
      };
    };
  };
}
