{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    apps.enable = lib.mkEnableOption "enables some apps";
  };
  config = lib.mkIf config.apps.enable {
    home.packages = with pkgs; [
      _1password-gui
      discord
      zoom-us
    ];
    # need to set this later for SSO
    # xdg-mime default Zoom.desktop x-scheme-handler/zoommtg
  };
}
