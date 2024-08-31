local M = {}

---@class fzf_lua_zoxide.Config
---@field zoxide? string Zoxide executable
---@field add_on_dir_changed? boolean Whether to automatically add to Zoxide on nvim DirChanged event

---@class fzf_lua_zoxide.Config
local default_config = {
	zoxide = "zoxide",
	add_on_dir_changed = true,
}

---@param opts? fzf_lua_zoxide.Config
M.setup = function(opts)
	local config = vim.tbl_deep_extend("keep", opts or {}, default_config)
	for k, v in pairs(config) do
		M[k] = v
	end

	if M.add_on_dir_changed then
		vim.api.nvim_create_autocmd("DirChanged", {
			callback = function(args)
				local directory = args.file
				os.execute(string.format("%s add %s", M.zoxide, directory))
			end,
		})
	end
end

---Opens a directory
---@class fzf_lua_zoxide.OpenOptions
---@field preview? string The command to run in the preview window
---@field callback? fun(selected: string) Callback to run on select
M.open = function(opts)
	---@class fzf_lua_zoxide.OpenOptions
	local o = vim.tbl_deep_extend("keep", opts or {}, { preview = "ls {}", callback = function() end })

	local fzf_lua = require("fzf-lua")
	fzf_lua.fzf_exec(string.format("%s query -l", M.zoxide), {
		fzf_opts = {
			["--preview"] = o.preview,
		},
		actions = {
			["default"] = function(selected)
				vim.cmd("cd " .. selected[1])
				o.callback(selected[1])
			end,
		},
	})
end

return M
