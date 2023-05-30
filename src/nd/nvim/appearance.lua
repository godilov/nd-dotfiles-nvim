local color_cache_res = require 'nd.res.color.cache'

local color_fn        = require 'nd.nvim.color'

local color_scheme_fn = color_cache_res.get_nvim

local indent          = require 'indent_blankline'
local colorizer       = require 'colorizer'
local lualine         = require 'lualine'
local bufferline      = require 'bufferline'
local dashboard       = require 'dashboard'

return function(config)
    local color_scheme = color_scheme_fn(config.color)

    color_fn(color_scheme.highlight)

    colorizer.setup { '*' }

    indent.setup {
        use_treesitter = true,
        show_current_context = true,
        bufname_exclude = {
            '[No Name]',
        },
    }

    lualine.setup {
        options = {
            theme = color_scheme.special.lualine,
        },
    }

    bufferline.setup {
        options = {
            mode = 'tabs',
            numbers = 'none',
            close_command = '',
            right_mouse_command = '',
            left_mouse_command = '',
            middle_mouse_command = '',
            always_show_bufferline = true,
            diagnostics = 'nvim_lsp',
            diagnostics_update_in_insert = true,
            diagnostics_indicator = function(count, _, _, _)
                return '(' .. count .. ')'
            end,
        },
    }

    dashboard.setup {
        theme = 'hyper',
        disable_move = true,
        shortcut_type = 'letter',
        config = color_scheme.etc.dashboard.config,
    }
end
