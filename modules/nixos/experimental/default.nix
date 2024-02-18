{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.nix.experimental;
in {
  options.nix.experimental = {
    flakes = {
      enable = mkEnableOption "Whether to enable flakes.";
      package = mkOption {
        default = pkgs.nixFlakes;
        example = pkgs.nixFlakes;
        type = types.package;
        description = "The package to be used to enable flakes.";
      };
    };
    nix-command.enable = mkEnableOption "Whether to enable nix-command.";
  };

  config = {
    nix = {
      package = mkIf cfg.flakes.enable cfg.flakes.package;
      extraOptions = ''
        experimental-features = ${
          (if cfg.flakes.enable then "flakes " else "") +
          (if cfg.nix-command.enable then "nix-command " else "")
        }
      '';
    };
  };
}
