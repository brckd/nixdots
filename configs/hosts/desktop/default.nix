{ config, pkgs, ... }:

{
  imports = [
    ./configuration.nix
    ../../../modules/system
  ];

  config = {
    modules = {
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
  
    # Install fonts
    fonts.packages = with pkgs; [
      jetbrains-mono
      fira-code
    ];

    # Enable networking
    networking.networkmanager.enable = true;
    networking.hostName = "desktop"; # Define your hostname.
    
    # Enable experimental features
    nix = {
      package = pkgs.nixFlakes;
      extraOptions = ''
        experimental-features = nix-command flakes
      '';
    };

    networking.wg-quick.interfaces = {
      nixos = {
        autostart = false;
        dns = [ "10.2.0.1" ];
        privateKeyFile = "/root/secrets/wireguard/nixos";
        address = [ "10.2.0.2/32" ];
        listenPort = 51820;
        
        peers = [
          {
            publicKey = "tHhN+km281/X+TgM628NVZaa0fMVrUwN1E3e5z99C1Q=";
            allowedIPs = [ "0.0.0.0/0" "::/0" ];
            endpoint = "169.150.218.21:51820";
          }
        ];
      };

      desktop = {
        autostart = false;
        dns = [ "10.2.0.1" ];
        privateKeyFile = "/root/secrets/wireguard/desktop";
        address = [ "10.2.0.2/32" ];
        listenPort = 51820;
        
        peers = [
          {
            publicKey = "n4RGP+MGDzRHZ1eoPLQZgpuWxtjnW7qL8qzOP1DRvHo="; 
            allowedIPs = [ "0.0.0.0/0" "::/0" ];
            endpoint = "212.8.243.68:51820";
          }
        ];
      };
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.bricked = {
      isNormalUser = true;
      description = "Bricked";
      extraGroups = [ "networkmanager" "wheel" ];
    };

    # Enable automatic login for the user.
    services.getty.autologinUser = "bricked";
    };
}
