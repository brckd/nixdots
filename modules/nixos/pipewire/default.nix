{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.services.pipewire;
in {
  config = mkIf cfg.enable {
    services.pipewire = {
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
