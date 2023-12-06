{ pkgs, ... }:

{
  imports = [
   ./i3.nix
   ./rofi.nix
   ./wezterm.nix
  ];
}
