{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.networking.protonvpn;
in {
  options.networking.protonvpn = {
    enable = mkEnableOption "Whether to enable ProtonVPN using Wireguard.";

    autostart = mkOption {
      default = true;
      example = true;
      type = types.bool;
      description = "Wheter to automatically start the VPN on boot.";
    };

    name = mkOption {
      default = "protonvpn";
      example = "protonvpn";
      type = types.str;
      description = "The name of the Wireguard connection.";
    };

    address = mkOption {
      default = "10.2.0.2/32";
      example = "10.2.0.2/32";
      type = types.str;
      description = "The IP address of the VPN provider.";
    };

    port = mkOption {
      default = 51820;
      example = 51820;
      type = types.int;
      description = "The port of the VPN connection.";
    };

    endpoint = mkOption {
      example = "123.1.2.3";
      type = types.str;
      description = "The IP address of the VPN endpoint";
    };

    publicKey = mkOption {
      example = "0123456789abcdefgABCDEFG+==============";
      type = types.str;
      description = "The public key for the VPN connection.";
    };

    privateKeyFile = mkOption {
      example = /root/secrets/protonvpn;
      type = types.path;
      description = "The path where the private key for the VPN connection is securely stored at.";
    };

    dns = {
      enable = mkEnableOption "Whether to enable ProtonVPN's DNS.";
      address = mkOption {
        default = "10.2.0.1";
        example = "10.2.0.1";
        type = types.str;
        description = "The IP address of the DNS to use.";
      };
    };
  };

  config = mkIf cfg.enable {
    networking.wg-quick.interfaces.${cfg.name} = {
      autostart = cfg.autostart;
      address = [cfg.address];
      listenPort = cfg.port;
      privateKeyFile = "${cfg.privateKeyFile}";

      peers = [
        {
          publicKey = cfg.publicKey;
          allowedIPs = ["0.0.0.0/0" "::/0"];
          endpoint = "${cfg.endpoint}:${builtins.toString cfg.port}";
        }
      ];

      dns = mkIf cfg.dns.enable [cfg.dns.address];
    };
  };
}
