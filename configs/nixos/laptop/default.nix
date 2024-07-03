{pkgs, ...}: {
  imports = [
    ./configuration.nix
  ];

  config = {
    nix = {
      package = pkgs.nix;
      settings.experimental-features = ["nix-command" "flakes"];
    };
    locale = {
      timeZone = "Europe/Berlin";
      language = "en_US.UTF-8";
      units = "de_DE.UTF-8";
      layout = "de";
    };
    programs.hyprland.enable = true;
    services.xserver.displayManager = {
      sddm = {
        enable = true;
      };
      autoLogin.user = "bricked";
    };
    services.pipewire.enable = true;
    services.upower.enable = true;
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;

    # Enable networking
    networking.networkmanager.enable = true;
    networking.hostName = "laptop"; # Define your hostname.
    services.protonvpn = {
      enable = true;
      interface = {
        privateKeyFile = "/root/secrets/protonvpn";
        dns.enable = true;
      };
      endpoint = {
        publicKey = "ozbmrTpgMTEuR1N7KguQD6qCMJzamTNYtFungG3xpQ0=";
        ip = "138.199.7.234";
      };
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users = {
      bricked = {
        isNormalUser = true;
        description = "Bricked";
        extraGroups = ["networkmanager" "wheel"];
      };
      john = {
        isNormalUser = true;
        description = "John";
        extraGroups = ["networkmanager"];
      };
    };

    nixpkgs.config.allowUnfree = true;
  };
}
