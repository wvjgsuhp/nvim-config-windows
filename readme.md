# Neovim Config (Windows)

## Dependencies

1.  `rg`
2.  `ag`
3.  Python
4.  `fzf`

## Installation

```sh
pip install -r requirements.txt
nvim
```

## Fixes

1.  In `dein/repos/github.com/nvim-lua/plenary.nvim/lua/plenary/path.lua:279`,

    ```lua
    -- old
    return self:absolute() or self.filename

    -- new
    return self.filename or self:absolute()
    ```
