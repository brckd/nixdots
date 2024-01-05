{ config, pkgs, ... }:

{
  imports = [ ../../../modules/system ];

  config.modules = {
    hardware.enable = true;
    locale = {
      enable = true;
      timeZone = "Europe/Berlin";
      language = "en_US.UTF-8";
      units = "de_DE.UTF-8";
      layout = "de";
    };
    hyprland.enable = true;
    pipewire.enable = true;
    zsh = {
      enable = true;
      defaultUserShell = true;
    };
    git.enable = true;
  };

  options = {
    # Install fonts
    fonts.packages = with pkgs; [
      jetbrains-mono
      fira-code
    ];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Enable networking
    networking.networkmanager.enable = true;
    networking.hostName = "nixos"; # Define your hostname.
    
    # Enable experimental features
    nix = {
      package = pkgs.nixFlakes;
      extraOptions = ''
        experimental-features = nix-command flakes
      '';
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.bricked = {
      isNormalUser = true;
      description = "Bricked";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [];
    };

    # Enable automatic login for the user.
    services.getty.autologinUser = "bricked";

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Do not change
    system.stateVersion = "23.11";
  };
}
