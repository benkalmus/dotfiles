local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- =====================================================
-- Terminal Key Behavior
-- =====================================================
config.term = "wezterm" -- Report as wezterm terminal type
-- Kitty keyboard protocol and CSI-u encoding are DISABLED on purpose:
-- wezterm's kitty implementation is buggy (wez/wezterm#3593, #6982) and
-- its CSI-u encoding is explicitly "not recommended" by the wezterm docs.
-- Both schemes mis-encode arrows/PageUp/PageDown when negotiated through
-- tmux -> nvim, breaking those keys (ghostty works because its kitty
-- implementation is correct). xterm-compatible + modifyOtherKeys encoding
-- is used instead, which tmux translates correctly.
config.enable_kitty_keyboard = false
config.enable_csi_u_key_encoding = false

-- =====================================================
-- Font Configuration (Fira Code Nerd Font)
-- =====================================================
config.font = wezterm.font("FiraCode Nerd Font", {
	weight = "Regular",
	stretch = "Normal",
	style = "Normal",
})
config.font_size = 10.0
config.harfbuzz_features = { "calt=1", "clig=1", "liga=1" } -- Enable font ligatures
-- config.anti_alias_custom_block_glyphs = true
config.max_fps = 90

-- =====================================================
-- Color Configuration (True Color / RGB)
-- =====================================================
config.color_scheme = "Dracula" -- Matches your Ghostty theme
config.enable_scroll_bar = false
config.scrollback_lines = 10000

-- =====================================================
-- Window Configuration
-- =====================================================
config.window_decorations = "TITLE"
config.window_background_opacity = 0.95
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.initial_cols = 120
config.initial_rows = 40

wezterm.on("update-status", function(window)
	local gradient =
		wezterm.color.gradient({ "#ff0000", "#00ff00", "#0000ff" }, window:active_pane().current_working_dir)
	window:set_right_status(wezterm.format({
		{ Text = " " .. window:active_pane().current_working_dir .. " " },
	}))
end)

-- =====================================================
-- Keyboard Configuration (Fix Ctrl+[, Ctrl+., etc.)
-- =====================================================
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false
config.audible_bell = "Disabled"

-- Key table for proper key forwarding through tmux
config.keys = {
	{
		key = "c",
		mods = "CTRL|SHIFT",
		action = wezterm.action.CopyTo("ClipboardAndPrimarySelection"),
	},
	{
		key = "v",
		mods = "CTRL|SHIFT",
		action = wezterm.action.PasteFrom("Clipboard"),
	},
	-- Existing key preservation for Neovim/Vim
	-- {
	-- 	key = "Tab",
	-- 	mods = "CTRL",
	-- 	action = wezterm.action.DisableDefaultAssignment,
	-- },
	{
		key = "[",
		mods = "CTRL",
		action = wezterm.action.SendKey({ key = "[", mods = "CTRL" }),
	},
	{
		key = "]",
		mods = "CTRL",
		action = wezterm.action.SendKey({ key = "]", mods = "CTRL" }),
	},
	{
		key = ".",
		mods = "CTRL",
		action = wezterm.action.SendKey({ key = ".", mods = "CTRL" }),
	},
	{
		key = ",",
		mods = "CTRL",
		action = wezterm.action.SendKey({ key = ",", mods = "CTRL" }),
	},
	{
		key = "LeftArrow",
		mods = "ALT",
		action = wezterm.action.SendKey({ key = "LeftArrow", mods = "ALT" }),
	},
	{
		key = "RightArrow",
		mods = "ALT",
		action = wezterm.action.SendKey({ key = "RightArrow", mods = "ALT" }),
	},
	{
		key = "UpArrow",
		mods = "ALT",
		action = wezterm.action.SendKey({ key = "UpArrow", mods = "ALT" }),
	},
	{
		key = "DownArrow",
		mods = "ALT",
		action = wezterm.action.SendKey({ key = "DownArrow", mods = "ALT" }),
	},
	-- Disable default key
	{
		key = "Enter",
		mods = "ALT",
		action = wezterm.action.DisableDefaultAssignment,
	},
}

-- =====================================================
-- Helper Functions
-- =====================================================
-- Set window title to show current ssh host
-- wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
-- 	local pane = tab.active_pane
-- 	local title = pane.title
--
-- 	-- Try to extract hostname from environment or current working directory
-- 	if pane.current_working_dir then
-- 		-- This might work if you're connected via ssh to a hostname
-- 		if pane.current_working_dir.hostname and pane.current_working_dir.hostname ~= "" then
-- 			title = pane.current_working_dir.hostname .. " - " .. title
-- 		end
-- 	end
--
-- 	-- Also check if hostname is in the environment
-- 	if wezterm.env.HOSTNAME and wezterm.env.HOSTNAME ~= "" then
-- 		title = wezterm.env.HOSTNAME .. " - " .. title
-- 	end
--
-- 	return {
-- 		{ Foreground = { Color = "#a9b1d6" } },
-- 		{ Text = " " .. title .. " " },
-- 	}
-- end)

return config
