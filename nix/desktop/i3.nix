{ pkgs, lib, ... }:

let 
  mod = "Mod4";
in {
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = mod;
      terminal = "${pkgs.wezterm}/bin/wezterm";

      fonts = ["DejaVu Sans Mono, FontAwesome 6"];

      keybindings = lib.mkOptionDefault {
        "${mod}+space" = "exec --no-startup-id ${pkgs.rofi}/bin/rofi -show combi -show-icons";
        "${mod}+x" = "exec sh -c '${pkgs.maim}/bin/maim -s | xclip -selection clipboard -t image/png'";
        "${mod}+Shift+x" = "exec sh -c '${pkgs.i3lock}/bin/i3lock -c 222222 & sleep 5 && xset dpms force of'";

        # Focus
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";

        # Move
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";

        # Browser
        "${mod}+b" = "exec firefox";
      };

      workspaceOutputAssign = [
        {
          workspace = "1";
          output = "DP-3";
        }
        {
          workspace = "2";
          output = "HDMI-1";
        }
      ];

      bars = [
        {
          position = "bottom";
          #statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${./i3status-rust.toml}";
        }
      ];
    };
  };
}
