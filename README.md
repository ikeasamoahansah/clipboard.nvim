<h1 align="center" style="font-weight: bold;">clipboard.nvim</h1>

<p align="center">A telescope-based picker of your recently yanked text</p>

## Features

- Keeps a history of your most recent yanks in a telescope picker
- Most recent yank first; re-yanking text **moves it to the front** instead of duplicating it
- Full multi-line yank text in the preview window (highlighted as markdown)
- Select an entry with `<CR>` to restore it to the yank register, then paste it with `p` / `P`
- Customizable history size and picker command

## Requirements

- [Neovim](https://neovim.io/) (≥ 0.7)
- [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

<h2 id="started">Getting started</h2> 

### Setup

Lazy.nvim 

```lua
return {
    'ikeasamoahansah/clipboard.nvim',
    dependencies = {
        "nvim-telescope/telescope.nvim"
    },
    config = function()
        require('clipboard').setup()
    end
}
```

Packer.nvim

```lua
require('packer').startup(function()
  use {
    'ikeasamoahansah/clipboard.nvim',
    dependencies = {
        "nvim-telescope/telescope.nvim"
    },
    config = function()
      require('clipboard').setup()
    end
  }
end)
```

### Usage

Use `:Yank` to open the picker and view the history of yanked scripts.

> [!NOTE]
> Only text yanked with the default yank register (plain `y`) is tracked.
> Yanks into an explicit register (e.g. `"ayiw`) do not update the yank
> register and are not recorded.

### Configuration

```lua
require("clipboard").setup({
  -- You can customize here

  history_size = 10, -- number of yanked scripts to store
  command_yank_history = "Yank", -- custom command to open the clipboard menu
})
```

| Option                 | Type   | Default  | Description                          |
| ---------------------- | ------ | -------- | ------------------------------------ |
| `history_size`         | number | `10`     | Number of yanked scripts to store    |
| `command_yank_history` | string | `"Yank"` | User command that opens the picker   |
