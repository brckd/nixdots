{ config, lib, ... }:

with lib;

let cfg = config.modules.hardware;
in {
  options.modules.hardware = {
    enable = mkEnableOption "Enable default hardware configuration.";

    path = mkOption {
      default = /etc/nixos/hardware-configuration.nix;
      example = /etc/nixos/hardware-configuration.nix;
      type = types.path;
      description = "The default hardware configuration to load.";
    };
  };

  config = mkIf cfg.enable (import cfg.path);
}
