{
  lib,
  pkgs,
  ...
}: {
  home = {
    username = "student";
    homeDirectory = "/home/student";
  };

  home.activation.placeConfig = let
    shellScript = pkgs.writeShellScript "" ''
      mkdir -p $HOME/Documents
      cp --recursive --dereference ${../../..} $HOME/Documents/nixdots
    '';
  in
    lib.hm.dag.entryAfter ["writeBoundary"] ''
      run ${shellScript}
    '';

  stylix = {
    enable = true;
    targets.steam.adwaitaForSteam.enable = false;
  };

  # Terminal
  programs.zsh.enable = true;
  programs.starship.enable = true;
  programs.direnv.enable = true;
  programs.kitty.enable = true;
  programs.git = {
    enable = true;
    extraConfig = {
      push.autoSetupRemote = true;
      pull.rebase = true;
    };
  };
  programs.gh.enable = true;
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # Editor
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
  };
  programs.vscode.enable = true;

  # Apps
  programs.librewolf = {
    enable = true;
    profiles.default.settings = let
      host = "proxy";
      port = 8080;
    in {
      "network.proxy.type" = 1;
      "network.proxy.share_proxy_settings" = true;
      "network.proxy.ssl" = host;
      "network.proxy.ssl_port" = port;
      "network.proxy.http" = host;
      "network.proxy.http_port" = port;
    };
  };
}