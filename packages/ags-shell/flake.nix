{
  description = "A desktop shell written in AGS";

  outputs = {nixdots, ...}: {
    devShells =
      builtins.mapAttrs (system: devShells: {
        default = devShells.agsShell;
      })
      nixdots.devShells;
  };

  inputs = {
    nixdots = {
      url = "../..";
      inputs.systems.follows = "systems";
    };
    systems.url = "github:nix-systems/default-linux";
  };
}
