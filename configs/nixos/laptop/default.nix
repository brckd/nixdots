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
      language = "en_DK.UTF-8";
      units = "en_DK.UTF-8";
      layout = "de";
    };
    stylix.enable = true;

    boot = {
      loader.systemd-boot.configurationLimit = 10;
      plymouth.enable = true;
      silent = true;
    };
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;
    environment.systemPackages = with pkgs; [
      comma
      busybox
    ];

    # Enable networking
    networking.hostName = "laptop"; # Define your hostname.

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users = {
      bricked = {
        isNormalUser = true;
        description = "Bricked";
        extraGroups = ["networkmanager" "wheel"];
      };
      personal = {
        isNormalUser = true;
        description = "Personal";
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
