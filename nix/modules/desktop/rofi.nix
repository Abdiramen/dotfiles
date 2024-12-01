{ lib, config, ... }:

{
  options = {
    rofi.enable = lib.mkEnableOption "enables rofi configs";
  };
  config = lib.mkIf config.rofi.enable {
    programs.rofi = {
      enable = true;
    };
  };
}
