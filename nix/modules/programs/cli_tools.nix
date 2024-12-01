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
      bat
      git
      ripgrep
      jq
      bc
      ngrok
    ];
  };
}
