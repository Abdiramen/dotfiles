{ pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "vimto";
  home.homeDirectory = "/home/vimto";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [ ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/vimto/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # not sure where this was from
  fonts.fontconfig.enable = true;
  # monitors
  programs.autorandr = {
    enable = true;
    profiles = {
      "main" = {
        fingerprint = {
          dp3 = "00ffffffffffff0009d1767f45540000251f0104b53c22783b9325ad4f44a9260d5054a56b80d1fcd1e8d1c0b300a9c08180810081c0f8e300a0a0a032500820980455502100001e000000ff0044394d30313538313031390a20000000fd002890dede3c010a202020202020000000fc0042656e5120455832373830510a015c020334f1515d5e5f60613f40101f22212004131203012309070783010000e200cf67030c0010003878e305c301e60605016262216fc200a0a0a055503020350055502100001e565e00a0a0a029503020350055502100001a000000000000000000000000000000000000000000000000000000000000000000000000000000b3";
          hdmi = "00ffffffffffff0010ac1df1425031412e1d010380351e78ea15c5a75650a026115054a54b00714f8180a9c0d1c00101010101010101023a801871382d40582c45000f282100001e000000ff004a314c525630330a2020202020000000fc0044454c4c20453234323048530a000000fd00384c1e5311000a20202020202001fe020321f14c1f01020307121604131405902309070767030c001000384483010000023a801871382d40582c45000f282100001e011d8018711c1620582c25000f282100009e011d007251d01e206e2855000f282100001e8c0ad08a20e02d10103e96000f282100001800000000000000000000000000000000000000000000b7";
        };
        config = {
          dp3 = {
            enable = true;
            position = "1920x0";
            mode = "2560x1440";
          };
          hdmi = {
            enable = true;
            primary = true;
            position = "0x0";
            mode = "1920x1080";
          };
        };
      };
    };
  };

  imports = [
    ../../modules
  ];
  animation.enable = true;
  game_dev.enable = true;
  i3.enable = true;
  rofi.enable = true;
  wezterm-local = {
    enable = true;
    backgrounds = {
      enable = true;
      path = "/home/vimto/Pictures/Wallpapers/active";
    };
  };
  latex.enable = true;
  apps.enable = true;
}
