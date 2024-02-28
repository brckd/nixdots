inputs@{ configs, modules, ... }:

{
  home-manager = {
    # useGlobalPkgs = true;
    config = {
      imports = [
        "${modules}/home"
        "${configs}/home/droid"
      ];
    };
  };
}
