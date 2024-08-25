{ pkgs, ... }:

{
  home.packages = with pkgs; [
    aseprite
    godot_4
  ];
}
