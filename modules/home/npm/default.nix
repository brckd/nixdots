{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.npm;
in {
  options.programs.npm = {
    enable = lib.mkEnableOption "npm";

    package = lib.mkPackageOption pkgs ["nodePackages" "npm"] {
      example = "nodePackages_latest.npm";
    };

    npmrc = lib.mkOption {
      type = lib.types.lines;
      description = ''
        The user-wide npm configuration.
        See <https://docs.npmjs.com/misc/config>.
      '';
      default = ''
        prefix = ''${HOME}/.npm
      '';
      example = ''
        prefix = ''${HOME}/.npm
        https-proxy=proxy.example.com
        init-license=MIT
        init-author-url=https://www.npmjs.com/
        color=true
      '';
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = singleton cfg.package;
      file.".npmrc".text = cfg.npmrc;
    };
  };
}
