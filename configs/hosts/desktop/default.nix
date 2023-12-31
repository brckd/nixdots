{ config, pkgs, nix-colors, ... }:

{
  imports = [
    ./configuration.nix
    ../../../modules/system
  ];

  config = {
    colorScheme = nix-colors.colorSchemes.catppuccin-mocha;

    modules = {
      experimental = {
        flakes.enable = true;
        nix-command.enable = true;
      };
      locale = {
        timeZone = "Europe/Berlin";
        language = "en_US.UTF-8";
        units = "de_DE.UTF-8";
        layout = "de";
      };
      hyprland.enable = true;
      sddm = {
        enable = true;
        autoLogin.user = "bricked";
      };
      pipewire.enable = true;
      protonvpn = {
        enable = true;
        endpoint = "212.8.243.68";
        publicKey = "n4RGP+MGDzRHZ1eoPLQZgpuWxtjnW7qL8qzOP1DRvHo="; 
        privateKeyFile = /root/secrets/wireguard/desktop;
        dns.enable = true;
      };
      zsh.enable = true;
      git.enable = true;
    };
  
    # Install fonts
    fonts.packages = with pkgs; [
      jetbrains-mono
      fira-code
    ];

    # Enable networking
    networking.networkmanager.enable = true;
    networking.hostName = "desktop"; # Define your hostname.

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.bricked = {
      isNormalUser = true;
      description = "Bricked";
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };
}
