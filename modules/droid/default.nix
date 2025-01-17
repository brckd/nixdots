{
  inputs,
  lib,
  ...
}: {
  imports = with inputs; [
    stylix.nixOnDroidModules.stylix
    ./stylix
  ];
}
