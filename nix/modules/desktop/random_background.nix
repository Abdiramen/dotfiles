{ pkgs, config, lib, ... }:
{
  # TODO: merge local and remote wezterm with options
  options = {
    random-background.enable = lib.mkEnableOption "enable random backgrounds";
    random-background.backgrounds = lib.mkOption {
      type = lib.types.submodule {
        options = {
          enable = lib.mkEnableOption "random backgrounds";
          path = lib.mkOption {
            type = lib.types.str;
          };
        };
      };
    };
  };
  # why did I add this to the wezterm module this belongs in desktop?
  config = lib.mkIf config.random-background.enable {
    services.random-background = lib.mkIf config.random-background.backgrounds.enable {
      enable = true;
      display = "fill";
      #imageDirectory = "${/home/vimto/Pictures/Wallpapers/active}";
      imageDirectory = config.random-background.backgrounds.path;
      interval = "10m";
    };
  };
}
