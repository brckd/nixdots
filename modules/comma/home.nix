{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.programs.comma;
  inherit (builtins) isNull;
  inherit (lib) mkEnableOption mkPackageOption mkIf optional getExe' getExe;
in {
  options.programs.comma = {
    enable = mkEnableOption "Comma";
    package = mkPackageOption pkgs "comma" {
      nullable = true;
    };

    enableBashIntegration =
      mkEnableOption "Bash integration"
      // {
        default = true;
      };

    enableZshIntegration =
      mkEnableOption "Zsh integration"
      // {
        default = true;
      };

    enableFishIntegration =
      mkEnableOption "Fish integration"
      // {
        default = true;
      };
  };
  config = mkIf cfg.enable {
    home.packages = optional (cfg.package != null) cfg.package;

    programs.bash.initExtra = mkIf cfg.enableBashIntegration ''
      command_not_found_handle() {
        ${getExe pkgs.comma} "$@" < /dev/stdin
        return $?
      }
    '';

    programs.zsh.initExtra = mkIf cfg.enableZshIntegration ''
      command_not_found_handler() {
        ${getExe pkgs.comma} "$@" < /dev/stdin
        return $?
      }
    '';

    programs.fish.interactiveShellInit = mkIf cfg.enableFishIntegration ''
      function fish_command_not_found
        echo "comma: To consume streams, run `comma $argv[1]`." >&2
        ${getExe pkgs.comma} $argv
      end
    '';
  };
}
