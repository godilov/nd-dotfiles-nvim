# nd-dotfiles-nvim

Fast and reliable Nvim config.  
Designed to be used as source code without any additional tools or package managers.

## Requirements

- Linux
- LuaJIT

The config depends on [nd-dotfiles-lib](https://github.com/GermanOdilov/nd-dotfiles-lib) and [nd-dotfiles-res](https://github.com/GermanOdilov/nd-dotfiles-res), which requires Linux and LuaJIT.

## Usage

Simply copy the whole config to `~/.config/nvim`.

## Philosophy

The config contains only nvim-specific things and settings to keep it clean and small:
- Vim options
- Extra commands
- Plugins initialization
- Development tools initialization
- Color scheme initialization
- Key scheme initialization

All other functionality and resources are defined in nd dependencies.

