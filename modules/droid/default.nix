{
  inputs,
  self,
  ...
}: let
  internalModules = builtins.attrValues (builtins.removeAttrs self.nixOnDroidModules ["default"]);
  externalModules = with inputs; [
    stylix.nixOnDroidModules.stylix
  ];
in {
  system.stateVersion = "24.05";

  imports = internalModules ++ externalModules;
}
