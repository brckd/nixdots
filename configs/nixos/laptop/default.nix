{ config, pkgs, nix-colors, ... }:

{
  imports = [
    ./configuration.nix
  ];

  config = {
    colorScheme = nix-colors.colorSchemes.catppuccin-mocha;

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
    programs.git.enable = true;

    # Install fonts
    fonts.packages = with pkgs; [
      jetbrains-mono
      fira-code
    ];

    # Enable networking
    networking.networkmanager.enable = true;
    networking.hostName = "laptop"; # Define your hostname.
    networking.protonvpn = {
      enable = true;
      endpoint = "138.199.7.234";
      publicKey = "ozbmrTpgMTEuR1N7KguQD6qCMJzamTNYtFungG3xpQ0="; 
      privateKeyFile = /root/secrets/protonvpn;
      dns.enable = true;
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users = {
      bricked = {
        isNormalUser = true;
        description = "Bricked";
        extraGroups = [ "networkmanager" "wheel" ];
      };
      john = {
        isNormalUser = true;
        description = "John";
        extraGroups = [ "networkmanager" ];
      };
    };

    nixpkgs.config.allowUnfree = true;
  };
}
