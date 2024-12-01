{ config, lib, ... }:

{
  # TODO: merge local and remote wezterm with options
  options = {
    wezterm-remote.enable = lib.mkEnableOption "enable remote wezterm";
  };
  config = lib.mkIf config.wezterm-local.enable {
    programs.wezterm = {
      enable = true;
      extraConfig = ''
        local act = wezterm.action
        -- The filled in variant of the < symbol
        local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
        -- The filled in variant of the > symbol
        local SOLID_RIGHT_ARROW = utf8.char(0xe0b0)

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

        return {
          -- hide_tab_bar_if_only_one_tab = true,
          use_fancy_tab_bar = false,
          tab_bar_at_bottom = true,
          harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0'},
          font_size = 10,
          color_scheme = "AlienBlood",
          window_padding = {
            left = 0,
            right = 0,
            top = 0,
            bottom = 0,
          },
          inactive_pane_hsb = {
            saturation = 0.5,
            brightness = 0.5,
          },
          keys = {
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
          },
        }
      '';
    };
  };
}
