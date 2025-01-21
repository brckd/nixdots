{
  config,
  lib,
  ...
}: let
  inherit (builtins) attrNames concatStringsSep mapAttrs;
  inherit (lib) mkIf attrsToList;
  cfg = config.services.kanata;

  tapTime = 300;
  holdTime = 300;
  keyMaps =
    {
      caps.tap = "esc";
    }
    // mapAttrs (k: v: v // {mod = true;}) {
      a.hold = "lmet";
      s.hold = "lalt";
      d.hold = "lsft";
      f.hold = "lctl";
      j.hold = "rctl";
      k.hold = "rsft";
      l.hold = "ralt";
      ";".hold = "rmet";
    };
  keys = attrNames keyMaps;

  sExp = args: "(${concatStringsSep " " (map toString args)})";
  tapHold = tapKey: holdKey: sExp ["tap-hold" tapTime holdTime tapKey holdKey];

  aliases =
    concatStringsSep "\n  "
    (map ({
        name,
        value,
      }: let
        tapHoldAction = tapHold (value.tap or name) (value.hold or name);
      in "${name} ${
        if value.mod or false
        then sExp ["multi" "f24" tapHoldAction]
        else tapHoldAction
      }")
      (attrsToList keyMaps));
in {
  config = mkIf cfg.enable {
    services.kanata = {
      keyboards.default = {
        extraDefCfg = ''
          process-unmapped-keys yes
        '';
        config = ''
          (defsrc
            ${concatStringsSep " " keys}
          )

          (defalias
            ${aliases}
          )

          (deflayer base
            ${concatStringsSep " " (map (k: "@${k}") keys)}
          )
        '';
      };
    };
  };
}
