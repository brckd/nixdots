{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.nautilus.extensions.python;
in {
  options.programs.nautilus.extensions.python = {
    enable = mkEnableOption "python extensions";
  };
  config = mkIf cfg.enable {
    environment = {
      sessionVariables.NAUTILUS_4_EXTENSION_DIR = mkForce "${pkgs.nautilus-python}/lib/nautilus/extensions-4";
      pathsToLink = [
        "/share/nautilus-python/extensions"
      ];

      systemPackages = with pkgs; [nautilus-python];
    };
  };
}
