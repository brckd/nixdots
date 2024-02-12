{ config, pkgs, lib, ... }:

with lib; {
  options.modules.discord = {
    enable = mkEnableOption "Enable Discord chat app.";
  };

  config = mkIf config.modules.discord.enable {
    home.packages = with pkgs; [ vesktop ];
  };
}
