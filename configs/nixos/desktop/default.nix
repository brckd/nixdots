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
      units = "en_DK.UTF-8";
      layout = "de";
    };
    programs.hyprland.enable = true;
    services.displayManager = {
      sddm.enable = true;
      autoLogin.user = "bricked";
    };
    services.pipewire.enable = true;
    services.upower.enable = true;
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;
    programs.steam.enable = true;
    programs.adb.enable = true;
    environment.systemPackages = with pkgs; [modrinth-app jdk cartridges ungoogled-chromium xdg-desktop-portal-gtk];

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
        publicKey = "avWNWfLsQAQhnRAioRnpZ2LI1nMqd73lWr5zt4aZ1Vo=";
        ip = "212.8.253.154";
      };
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users = {
      bricked = {
        isNormalUser = true;
        description = "Bricked";
        extraGroups = ["networkmanager" "wheel" "adbuser"];
      };
      personal = {
        isNormalUser = true;
        description = "Personal";
        extraGroups = ["networkmanager" "wheel"];
      };
      john = {
        isNormalUser = true;
        description = "John";
        extraGroups = ["networkmanager" "wheel"];
      };
    };

    nixpkgs.config.allowUnfree = true;
  };
}
