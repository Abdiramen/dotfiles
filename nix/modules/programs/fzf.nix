{ config, lib, ... }:
{
  options = {
    fzf.enable = lib.mkEnableOption "enables fzf configs";
  };
  config = lib.mkIf config.fzf.enable {
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
