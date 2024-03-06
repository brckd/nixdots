{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./configuration.nix
  ];

  config = {
    nix.experimental = {
      flakes.enable = true;
      nix-command.enable = true;
    };
    locale = {
      timeZone = "Europe/Berlin";
      language = "en_US.UTF-8";
      units = "de_DE.UTF-8";
      layout = "de";
    };
    programs.hyprland.enable = true;
    services.xserver = {
      enable = true;
      displayManager = {
        sddm = {
          enable = true;
        };
        autoLogin.user = "bricked";
      };
    };
    services.pipewire.enable = true;
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;
    programs.steam.enable = true;

    # Enable networking
    networking.networkmanager.enable = true;
    networking.hostName = "desktop"; # Define your hostname.
    services.protonvpn = {
      enable = true;
      interface = {
        privateKeyFile = "/root/secrets/protonvpn";
        dns.enable = true;
      };
      endpoint = {
        publicKey = "fHQZJoKLRiQi/5QcPLE91BT8JTcArjR0l/PXWfv56yw=";
        ip = "169.150.218.6";
      };
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users = {
      bricked = {
        isNormalUser = true;
        description = "Bricked";
        extraGroups = ["networkmanager" "wheel"];
      };
    };

    nixpkgs.config.allowUnfree = true;
  };
}
