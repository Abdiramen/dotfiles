{ config, pkgs, ... }:

{
  imports = [
    ../common.nix
    ../../programs/direnv.nix
    ../../desktop
  ];

  home.packages = with pkgs; [
    _1password-gui
  ];
}
