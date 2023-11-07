{ config, pkgs, ... }:

{
  imports = [
    ../common.nix
    ../../programs/wezterm.nix
  ];
}
