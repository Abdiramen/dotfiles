{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    cli_tools.enable = lib.mkEnableOption "some cli tools";
  };

  config = lib.mkIf config.cli_tools.enable {
    home.packages = with pkgs; [
      curl
      # cat with wings
      bat
      git
      ripgrep
      # json parsing tool
      jq
      # yaml wrapper for jq
      yq-go
      # binary calculator
      bc
      ngrok
    ];
  };
}
