{ pkgs, ... }:

{
  home.username = "oz";
  home.homeDirectory = "/home/vimto";
  home.stateVersion = "24.11";
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [ ];
  home.file = {};
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
 
  imports = [
    ../../modules
  ];
  wezterm-remote = {
    enable = true;
  };
}
