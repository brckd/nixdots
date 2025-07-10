{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  inherit (lib) mkIf;
  cfg = config.services.mithril-shell;
in {
  imports = [inputs.mithril-shell.homeManagerModules.default];

  config = mkIf cfg.enable {
    home.packages = with pkgs; [grim];
    services.swaync.enable = true;

    services.mithril-shell = mkIf (config.stylix.enable && cfg.integrations.stylix.enable) {
      theme.colors.primary = config.lib.stylix.colors.base0D;
      settings = {
        lockCommand = "${pkgs.hyprlock}/bin/hyprlock --immediate";
        powerMenuEntries = [
          {
            label = "Suspend";
            command = "systemctl suspend";
          }
          {
            label = "Restart";
            command = "systemctl reboot";
            confirmation = "Are you sure you want to restart the computer?";
          }
          {
            label = "Restart to UEFI";
            command = "systemctl reboot --firmware-setup";
            confirmation = "Are you sure you want to restart to UEFI?";
          }
          {
            label = "Power Off";
            command = "systemctl poweroff";
            confirmation = "Are you sure you want to power off the computer?";
          }
          {
            label = "Log Out";
            command = "uwsm stop";
            confirmation = "Are you sure you want to log out of this session?";
          }
        ];
      };
    };
  };
}
