{ config, lib, pkgs, ... }:

with lib;

let cfg = config.modules.zsh;
in {
  options.modules.zsh = {
    enable = mkEnableOption "Enable Zsh.";
    defaultUserShell = mkOption {
      default = true;
      example = true;
      type = types.bool;
      description = "Set Zsh as default user shell.";
    };
  };

  config = mkIf cfg.enable {
    programs.zsh.enable = true;
    users.defaultUserShell = mkIf cfg.defaultUserShell pkgs.zsh;
  };
}
