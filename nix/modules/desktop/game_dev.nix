{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    game_dev.enable = lib.mkEnableOption "enable game dev programs";
  };
  config = lib.mkIf config.game_dev.enable {
    home.packages = with pkgs; [
      #aseprite # might also make this required here
      godot_4
      itch
    ];
  };
}
