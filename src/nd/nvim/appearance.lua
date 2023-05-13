local scheme_fn  = require 'nd.resources.color.cache'

local color_fn   = require 'nd.nvim.color'

local indent     = require 'indent_blankline'
local colorizer  = require 'colorizer'
local lualine    = require 'lualine'
local bufferline = require 'bufferline'
local startup    = require 'startup'

return function(color_config)
    local scheme = scheme_fn(color_config)

    color_fn(scheme.highlight)

    colorizer.setup { '*' }

    indent.setup {
        show_current_context = true,
    }

    lualine.setup {
        options = {
            theme = nil,
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

    startup.setup {
        theme = 'evil',
    }
end
