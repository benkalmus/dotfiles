local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- =====================================================
-- Font Configuration (Fira Code Nerd Font)
-- =====================================================
config.font = wezterm.font('FiraCode Nerd Font', {
  weight = 'Regular',
  stretch = 'Normal',
  style = 'Normal',
})
config.font_size = 11.0
config.harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' } -- Enable font ligatures
config.anti_alias = true
config.clear_type_options = {
  enhance_contrast = true,
  gamma = 1.0,
}

-- =====================================================
-- Color Configuration (True Color / RGB)
-- =====================================================
config.color_scheme = 'Tokyo Night' -- Matches your tmux theme
config.enable_scroll_bar = true
config.scrollback_lines = 10000

-- =====================================================
-- Window Configuration
-- =====================================================
config.window_decorations = 'RESIZE'
config.window_background_opacity = 0.95
config.window_padding = {
  left = 8,
  right = 8,
  top = 8,
  bottom = 8,
}
config.initial_cols = 120
config.initial_rows = 30

-- =====================================================
-- Keyboard Configuration (Fix Ctrl+[, Ctrl+., etc.)
-- =====================================================
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false
config.audible_bell = 'Disabled'

-- Key table for proper key forwarding through tmux
config.keys = {
  -- Disable WezTerm's default tab handling to let tmux receive Ctrl+Tab
  {
    key = 'Tab',
    mods = 'CTRL',
    action = wezterm.action.DisableDefaultAssignment,
  },
  -- Ensure Ctrl+[ and Ctrl+] are sent directly (for vim/nvim)
  {
    key = '[',
    mods = 'CTRL',
    action = wezterm.action.SendKey { key = '[', mods = 'CTRL' },
  },
  {
    key = ']',
    mods = 'CTRL',
    action = wezterm.action.SendKey { key = ']', mods = 'CTRL' },
  },
  -- Ensure Ctrl+. and Ctrl+, are sent directly
  {
    key = '.',
    mods = 'CTRL',
    action = wezterm.action.SendKey { key = '.', mods = 'CTRL' },
  },
  {
    key = ',',
    mods = 'CTRL',
    action = wezterm.action.SendKey { key = ',', mods = 'CTRL' },
  },
  -- Alt+Arrow keys for tmux pane navigation (matches your tmux config)
  {
    key = 'LeftArrow',
    mods = 'ALT',
    action = wezterm.action.SendKey { key = 'LeftArrow', mods = 'ALT' },
  },
  {
    key = 'RightArrow',
    mods = 'ALT',
    action = wezterm.action.SendKey { key = 'RightArrow', mods = 'ALT' },
  },
  {
    key = 'UpArrow',
    mods = 'ALT',
    action = wezterm.action.SendKey { key = 'UpArrow', mods = 'ALT' },
  },
  {
    key = 'DownArrow',
    mods = 'ALT',
    action = wezterm.action.SendKey { key = 'DownArrow', mods = 'ALT' },
  },
}

-- =====================================================
-- SSH Configuration
-- =====================================================
-- Define SSH connections for quick access
config.ssh_domains = {
  {
    name = 'remote-server',
    remote_address = 'your-server-ip-or-hostname',
    username = 'your-username',
    default_cwd = '~',
  },
}

-- =====================================================
-- Advanced Terminal Settings
-- =====================================================
config.term = 'wezterm' -- Report as wezterm terminal type
config.enable_kitty_keyboard = true -- Modern keyboard protocol (optional)
config.enable_csi_u_key_encoding = true -- Better key encoding for special keys

-- =====================================================
-- Helper Functions
-- =====================================================
-- Set window title to show current ssh host
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local pane = tab.active_pane
  local title = pane.title
  -- Extract ssh hostname if present
  if pane.current_working_dir and pane.current_working_dir.hostname then
    local hostname = pane.current_working_dir.hostname
    if hostname ~= '' then
      title = hostname .. ' - ' .. title
    end
  end
  return {
    { Foreground = { Color = '#a9b1d6' } },
    { Text = ' ' .. title .. ' ' },
  }
end)

return config
