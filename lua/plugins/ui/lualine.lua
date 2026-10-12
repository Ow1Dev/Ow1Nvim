vim.pack.add({
	{ src = "https://github.com/nvim-lualine/lualine.nvim", name = "lualine" },
})

require("lualine").setup {
  options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		always_show_tabline = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
			refresh_time = 16, -- ~60fps
			events = {
				"WinEnter",
				"BufEnter",
				"BufWritePost",
				"SessionLoadPost",
				"FileChangedShellPost",
				"VimResized",
				"Filetype",
				"CursorMoved",
				"CursorMovedI",
				"ModeChanged",
			},
		},
  },
  sections = {
  	lualine_a = {
			"mode",
			{
				function()
					local reg = vim.fn.reg_recording()
					if reg == "" then
						return ""
					end -- not recording
					return "MACRO " .. string.upper(tostring(reg))
				end,
			},
		},
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
    lualine_x = { "filetype" },
		lualine_y = { "lsp_status" },
    lualine_z = {},
  },
	inactive_sections = {
		lualine_a = {},
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
  extensions = { },
}
