{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.sddm;
in {
  options.modules.sddm = {
    enable = mkEnableOption "Enable SDDM display manager.";
    autoLogin.user = mkOption {
      default = null;
      type = with types; nullOr str;
      description = "User to be used for the automatic login.";
    };
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      displayManager = {
        sddm = {
          enable = true;
          theme = "catppuccin-sddm-corners";
          wayland.enable = true;
        };
        autoLogin.user = cfg.autoLogin.user;
      };
    };

    environment.systemPackages = with pkgs; [
      catppuccin-sddm-corners
      libsForQt5.qtbase
      libsForQt5.qtsvg
      libsForQt5.qtgraphicaleffects
      libsForQt5.qtquickcontrols2
    ];
  };
}
