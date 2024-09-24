{
  pkgs,
  lib,
  ...
}:
with lib; {
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
    stylix.enable = true;

    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        libGL
        vulkan-loader
        xorg.libX11
        xorg.libXcursor
        xorg.libXext
        xorg.libXi
        xorg.libXinerama
        xorg.libXrandr
        xorg.libXrender
      ];
    };
    boot = {
      loader.systemd-boot.configurationLimit = 10;
      plymouth.enable = true;
    };
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;
    programs.steam.enable = true;
    programs.adb.enable = true;
    environment.systemPackages = with pkgs; [
      nodejs_22
      busybox
      jdk
      cutter
      xdg-desktop-portal-gtk
      wineWowPackages.waylandFull
      winetricks
      mono5
      cartridges
      modrinth-app
      itch
    ];

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
