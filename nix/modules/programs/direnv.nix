{ config, lib, ... }:
{
  options = {
    direnv.enable = lib.mkEnableOption "enables direnv configs";
  };
  config = lib.mkIf config.direnv.enable {
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
