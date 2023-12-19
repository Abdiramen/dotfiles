{ config, pkgs, ... }:

{
  imports = [
    ../common.nix
    ../../local
    ../../desktop
  ];

  home.packages = with pkgs; [
    _1password-gui
  ];
}
