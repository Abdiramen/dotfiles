{ config, pkgs, ... }:

{
  imports = [
    ../common.nix
    ../../programs/direnv.nix
  ];

  # allow home manager to manage shell
  programs.bash = {
    enable = true;
    sessionVariables = {
      EDITOR = "vim";
    };
    initExtra = ''
      # see https://nix-community.github.io/home-manager/index.html#ch-installation
      . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      exec ~/.nix-profile/bin/zsh
    '';
  };
  # add home-manager programs to ubuntu application
  # source: https://github.com/nix-community/home-manager/issues/1439#issuecomment-1106208294
  home.activation = {
    linkDesktopApplications = {
      after = [ "writeBoundary" "createXdgUserDirectories" ];
      before = [ ];
      data = ''
        rm -rf ${config.xdg.dataHome}/"applications/home-manager"
        mkdir -p ${config.xdg.dataHome}/"applications/home-manager"
        cp -Lr ${config.home.homeDirectory}/.nix-profile/share/applications/* ${config.xdg.dataHome}/"applications/home-manager/"
      '';
    };
  };

  programs.zsh.initExtra = ''
    alias wezterm="flatpak run org.wezfurlong.wezterm"
    '';

  home.packages = with pkgs; [
    _1password-gui
  ]
}
