{ config, pkgs, lib, ... }:

with lib; {
  options.modules.librewolf = {
    enable = mkEnableOption "Enable Librewolf browser.";
  };

  config = mkIf config.modules.librewolf.enable {
    programs.librewolf = {
      enable = true;
      settings = {
        "webgl.disabled" = false;
      };
    };
  };
}
