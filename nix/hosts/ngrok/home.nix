{ pkgs, ... }:

{
  home.username = "oz";
  home.homeDirectory = "/home/oz";
  home.stateVersion = "24.11";
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [ ];
  home.file = {};
  home.sessionVariables = {
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  imports = [
    dotfiles/nix/modules
  ];

  programs.bash = {
    enable = true;
    initExtra = ''
      # see https://nix-community.github.io/home-manager/index.html#ch-installation
      #. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      exec ~/.nix-profile/bin/zsh
    '';
    profileExtra = ''
      PATH=~/.nix-profile/bin:$PATH
    '';
  };

  wezterm-remote = {
    enable = true;
  };
}
