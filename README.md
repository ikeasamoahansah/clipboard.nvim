<h1 align="center" style="font-weight: bold;">clipboard.nvim ✂️</h1>

<p align="center">A plugin for viewing recently yanked scripts</p>
 
<h2 id="started">🚀 Getting started</h2> 

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
use ```:Yank``` to view history of yanked scripts

### Configuration
```lua
require("clipboard").setup({
  -- You can customize here

  history_size = 10, -- number of yanked scripts to store
  command_yank_history = "Yank", -- custom command to open the clipboard menu
})
```
