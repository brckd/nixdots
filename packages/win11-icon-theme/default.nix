{
  lib,
  pkgs,
  ...
}: let
  inherit (builtins) fetchGit;
in
  pkgs.stdenvNoCC.mkDerivation {
    pname = "win11-icon-theme";
    version = "1.0.0";

    src = fetchGit {
      url = "https://github.com/yeyushengfan258/Win11-icon-theme.git";
      ref = "main";
      rev = "1e71bafc73d8731b74f294908ffd6ddabfe6e4a9";
    };

    buildInputs = [pkgs.bash (pkgs.writeScriptBin "gtk-update-icon-cache" "")];

    installPhase = ''
      theme=$out/share/icons/Win11
      mkdir --parents $theme

      cp --recursive ./src/* $theme
      cp --recursive ./links/* $theme

      # Delete broken symlinks
      find $theme -xtype l -delete
    '';

    meta = with lib; {
      description = "A colorful design icon theme for linux desktops";
      homepage = "https://github.com/yeyushengfan258/Win11-icon-theme";
      license = licenses.gpl3Only;
      platforms = platforms.all;
    };
  }
