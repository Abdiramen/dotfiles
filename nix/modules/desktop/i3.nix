{
  pkgs,
  lib,
  config,
  ...
}:

let
  mod = "Mod4";
  configFile = pkgs.writeText "i3status-rust.toml" ''
    icons_format = "{icon}"

    [theme]
    theme = "solarized-dark"
    [theme.overrides]
    idle_bg = "#123456"
    idle_fg = "#abcdef"

    [icons]
    icons = "awesome4"
    [icons.overrides]
    bat = ["|E|", "|_|", "|=|", "|F|"]
    bat_charging = "|^| "

    [[block]]
    block = "cpu"
    info_cpu = 20
    warning_cpu = 50
    critical_cpu = 90

    [[block]]
    block = "disk_space"
    path = "/"
    info_type = "available"
    alert_unit = "GB"
    interval = 20
    warning = 20.0
    alert = 10.0
    format = " $icon root: $available.eng(w:2) "

    [[block]]
    block = "memory"
    format = " $icon $mem_total_used_percents.eng(w:2) "

    [[block]]
    block = "sound"
    [[block.click]]
    button = "left"
    cmd = "${pkgs.pavucontrol}/bin/pavucontrol"

    [[block]]
    block = "time"
    interval = 5
    format = " $timestamp.datetime(f:'%a %d/%m %R') "
    [[block.click]]
    button = "left"
    cmd = "${pkgs.firefox}/bin/firefox https://calendar.google.com/calendar/u/0/r"
  '';
in
{
  options = {
    i3.enable = lib.mkEnableOption "enables i3 configs";
  };
  config = lib.mkIf config.i3.enable {
    xsession.windowManager.i3 = {
      enable = true;
      config = {
        modifier = mod;
        terminal = "${pkgs.wezterm}/bin/wezterm";

        fonts = {
          names = [
            "DejaVu Sans Mono"
            "FontAwesome 6"
            "JetBrains Mono"
          ];
        };

        keybindings = lib.mkOptionDefault {
          "${mod}+space" = "exec --no-startup-id ${pkgs.rofi}/bin/rofi -show combi -show-icons";
          "${mod}+x" = "exec sh -c '${pkgs.maim}/bin/maim -s | xclip -selection clipboard -t image/png'";
          "${mod}+Shift+x" = "exec --no-startup-id xflock4";

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

          # Scratch pad
        };

        workspaceOutputAssign = [
          {
            workspace = "1";
            output = "DP-1";
          }
          {
            workspace = "2";
            output = "HDMI-1";
          }
        ];

        bars = [
          {
            position = "bottom";
            statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${configFile}";
          }
        ];
      };
    };
  };
}
