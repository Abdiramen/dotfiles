{ pkgs, ... }:

{
  imports = [
    ../common.nix
    ../../local
    ../../desktop
    ../../game_dev
  ];

  home.packages = with pkgs; [ _1password-gui discord ];
}
