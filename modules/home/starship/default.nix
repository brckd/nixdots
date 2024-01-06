{ config, pkgs, lib, ... }:

with lib; {
  options.modules.starship = {enable = mkEnableOption "starship"; };

  config = mkIf config.modules.starship.enable {
    programs.starship = {
      enable = true;
      enableZshIntegration = config.modules.zsh.enable;
    };
  };
}
