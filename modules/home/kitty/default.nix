{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.kitty;
in {
  options.modules.kitty = {
    enable = mkEnableOption "Enable Kitty terminal emulator.";
  };

  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = config.modules.zsh.enable;
      theme = replaceStrings [" "] ["-"] config.colorScheme.name; 

      font = {
        package = pkgs.jetbrains-mono;
        name = "JetBrains Mono";
      };

      settings = {
        single_window_padding_width = 10;
      };
    };
  };
}
