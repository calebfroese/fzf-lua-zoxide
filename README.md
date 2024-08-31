# fzf-lua-zoxide

Neovim extension plugin for [fzf-lua](https://github.com/ibhagwan/fzf-lua) to integrate with [zoxide](https://github.com/ajeetdsouza/zoxide).

This provides the capability to open recently used directories, and sync with zoxide when directories are opened in Neovim.

## Installation

This project depends on [fzf-lua](https://github.com/ibhagwan/fzf-lua), make sure it is set up correctly before continuing.

Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
    "calebfroese/fzf-lua-zoxide",
    dependencies = { "ibhagwan/fzf-lua" },
    config = function()
        require('fzf-lua-zoxide').setup()
    end
}
```

Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use { "calebfroese/fzf-lua-zoxide",
    requires = { "ibhagwan/fzf-lua" }
}
```

## Usage

```lua
:lua require('fzf-lua-zoxide').open()
```

or assign a keymapping

```lua
vim.keymap.set("n", "<c-O>", require('fzf-lua-zoxide').open, { desc = "Fzf Dirs" })
```

Options can be provided to `open`:

```lua
require('fzf-lua-zoxide').open({
    ---@field preview? string The command to run in the preview window
    preview = "ls -la {}",
    ---@field callback? fun(selected: string) Callback to run on select
    callback = function()
        -- For example, you could open the directory in netrw after selecting one
        vim.cmd("e " .. selected)
    end,
})
```

By default the plugin simply calls `ls {}` to populate the preview window.

## Configuration

The plugin can be configured with the following options:

```lua
require('fzf-lua-zoxide').setup({
    ---@field zoxide? string Zoxide executable
    zoxide = "~/.bin/zoxide",
    ---@field add_on_dir_changed? boolean Whether to automatically add to Zoxide on nvim DirChanged event
    add_on_dir_changed = true,
})
```

### Default Configuration

```lua
{
    zoxide = "zoxide",
    add_on_dir_changed = true,
}
```

