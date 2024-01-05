{ config, lib, ... }:

with lib;

let cfg = config.modules.pipewire;
in {
  options.modules.pipewire = {
    enable = mkEnableOption "Enable Pipewire sound.";
  };

  config = mkIf cfg.enable {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
