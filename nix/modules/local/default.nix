{ config, lib, ... }:
{
  # TODO: merge local and remote wezterm with options
  options = {
    wezterm-local.enable = lib.mkEnableOption "enable local wezterm";
    wezterm-local.backgrounds = lib.mkOption {
      type = lib.types.submodule {
        options = {
          enable = lib.mkEnableOption "random backgrounds";
          path = lib.mkOption {
            type = lib.types.str;
          };
        };
      };
    };
  };
  # why did I add this to the wezterm module this belongs in desktop?
  config = lib.mkIf config.wezterm-local.enable {
    services.random-background = lib.mkIf config.wezterm-local.backgrounds.enable {
      enable = true;
      display = "fill";
      #imageDirectory = "${/home/vimto/Pictures/Wallpapers/active}";
      imageDirectory = config.wezterm-local.backgrounds.path;
      interval = "10m";
    };

    programs.wezterm = {
      enable = true;
      enableZshIntegration = true;
      #package = pkgs.wezterm;
      #colorSchemes = {
      #};
      extraConfig = ''
        local act = wezterm.action
        -- The filled in variant of the < symbol
        local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
        -- The filled in variant of the > symbol
        local SOLID_RIGHT_ARROW = utf8.char(0xe0b0)
        local config = wezterm.config_builder()

        wezterm.on(
          'format-tab-title',
          function(tab, tabs, panes, config, over, max_width)
            local edge_background = '#0b0022'
            local background = '#1b1032'
            local foreground = '#808080'

            if tab.is_active then
              background = '#2b2042'
              foreground = '#c0c0c0'
            elseif hover then
              background = '#3b3052'
              foreground = '#909090'
            end

            local edge_foreground = background

            -- ensure that the titles fit in the available space,
            -- and that we have room for the edges.
            local title = wezterm.truncate_right(tab.active_pane.title, max_width - 2)

            return {
              { Background = { Color = edge_background } },
              { Foreground = { Color = edge_foreground } },
              { Text = SOLID_LEFT_ARROW },
              { Background = { Color = background } },
              { Foreground = { Color = foreground } },
              { Text = title },
              { Background = { Color = edge_background } },
              { Foreground = { Color = edge_foreground } },
              { Text = SOLID_RIGHT_ARROW },
            }
          end
        )
        -- hide_tab_bar_if_only_one_tab = true,
        config.front_end = "WebGpu"
        config.use_fancy_tab_bar = false
        config.tab_bar_at_bottom = true
        config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0'}
        config.font = wezterm.font 'JetBrains Mono'
        config.font_size = 10
        config.color_scheme = "AlienBlood"
        config.window_background_opacity = 1
        config.window_padding = {
          left = 0,
          right = 0,
          top = 0,
          bottom = 0,
        }
        config.inactive_pane_hsb = {
          saturation = 0.5,
          brightness = 0.5,
        }
        config.keys = {
          {
            key = '"',
            mods = 'CTRL|SHIFT',
            action = act.SplitVertical { domain = 'CurrentPaneDomain' },
          },
          {
            key = '%',
            mods = 'CTRL|SHIFT',
            action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
          },
          {
            key = 'l',
            mods = "CTRL|SHIFT|ALT",
            action = act.ShowDebugOverlay,
          },
          -- vim movements
          {
            key = 'h',
            mods = 'CTRL|SHIFT',
            action = act.ActivatePaneDirection 'Left',
          },
          {
            key = 'j',
            mods = 'CTRL|SHIFT',
            action = act.ActivatePaneDirection 'Down',
          },
          {
            key = 'k',
            mods = 'CTRL|SHIFT',
            action = act.ActivatePaneDirection 'Up',
          },
          {
            key = 'l',
            mods = 'CTRL|SHIFT',
            action = act.ActivatePaneDirection 'Right',
          },
          {
            key = 'b',
            mods = 'CTRL|SHIFT',
            action = act.RotatePanes 'CounterClockwise',
          },
          {
            key = 'b',
            mods = 'CTRL|SHIFT|ALT',
            action = act.RotatePanes 'Clockwise'
          },
        }
        config.ssh_domains = {
          {
            name = 'ngrok',
            remote_address = 'ngrok-ec2',
            username = 'ubuntu',
            remote_wezterm_path = '/home/ubuntu/.nix-profile/bin/wezterm',
            --multiplexing = 'None', -- hopefully this opens in same terminal
          },
          {
            name = 'devbox',
            remote_address = 'devbox',
            username = 'oz',
            remote_wezterm_path = '/home/oz/.nix-profile/bin/wezterm',
          },
        }
        --config.set_environment_variables = {
        --    TERMINFO_DIRS = '/home/vimto/.nix-profile/share/terminfo',
        --}
        --config.term = "wezterm"

        return config
      '';
    };
  };
}
