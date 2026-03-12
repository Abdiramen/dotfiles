{
  config,
  lib,
  ...
}:
{

  # TODO: merge local and remote wezterm with options
  options = {
    wezterm.enable = lib.mkEnableOption "enable wezterm";
  };

  config = lib.mkIf config.wezterm.enable {
    programs.wezterm = {
      enable = true;
      enableZshIntegration = true;
      #package = pkgs.wezterm;
      #colorSchemes = {
      #};
      extraConfig = (builtins.readFile ./lua/local.lua);
    };
  };
}
