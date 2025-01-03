{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    animation.enable = lib.mkEnableOption "enable 2d and 3d animation programs.";
  };
  config = lib.mkIf config.animation.enable {
    home.packages = with pkgs; [
      aseprite
      blender
    ];
  };
}
