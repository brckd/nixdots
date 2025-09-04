{config, lib, pkgs, inputs, ...}:

let
  inherit (lib) mkIf;

  cfg = config.programs.anyrun;

  anyrunPkgs = inputs.anyrun.packages.${pkgs.system};
in {
  config = mkIf cfg.enable {
    programs.anyrun.config = {
      closeOnClick = true;

      plugins = [
        anyrunPkgs.applications
        anyrunPkgs.symbols
        anyrunPkgs.rink
      ];
    };
  };
}
