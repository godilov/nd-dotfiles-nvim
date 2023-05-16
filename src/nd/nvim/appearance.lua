local cache_res  = require 'nd.res.color.cache'

local color_fn   = require 'nd.nvim.color'

local scheme_fn  = cache_res.get_nvim

local indent     = require 'indent_blankline'
local colorizer  = require 'colorizer'
local lualine    = require 'lualine'
local bufferline = require 'bufferline'
local dashboard  = require 'dashboard'

return function(color_config)
    local scheme = scheme_fn(color_config)

    color_fn(scheme.highlight)

    colorizer.setup { '*' }

    indent.setup {
        char = '|',
        char_blankline = '¦',
        use_treesitter = true,
        show_current_context = true,
        bufname_exclude = {
            '[No Name]',
        },
    }

    lualine.setup {
        options = {
            theme = scheme.special.lualine,
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
        config = {
            header = {
                '',
                '    ⢰⣧⣼⣯⠄⣸⣠⣶⣶⣦⣾⠄⠄⠄⠄⡀⠄⢀⣿⣿⠄⠄⠄⢸⡇⠄⠄ ',
                '    ⣾⣿⠿⠿⠶⠿⢿⣿⣿⣿⣿⣦⣤⣄⢀⡅⢠⣾⣛⡉⠄⠄⠄⠸⢀⣿⠄ ',
                '   ⢀⡋⣡⣴⣶⣶⡀⠄⠄⠙⢿⣿⣿⣿⣿⣿⣴⣿⣿⣿⢃⣤⣄⣀⣥⣿⣿⠄ ',
                '   ⢸⣇⠻⣿⣿⣿⣧⣀⢀⣠⡌⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠿⣿⣿⣿⠄ ',
                '  ⢀⢸⣿⣷⣤⣤⣤⣬⣙⣛⢿⣿⣿⣿⣿⣿⣿⡿⣿⣿⡍⠄⠄⢀⣤⣄⠉⠋⣰ ',
                '  ⣼⣖⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⢇⣿⣿⡷⠶⠶⢿⣿⣿⠇⢀⣤ ',
                ' ⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣽⣿⣿⣿⡇⣿⣿⣿⣿⣿⣿⣷⣶⣥⣴⣿⡗ ',
                ' ⢀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟  ',
                ' ⢸⣿⣦⣌⣛⣻⣿⣿⣧⠙⠛⠛⡭⠅⠒⠦⠭⣭⡻⣿⣿⣿⣿⣿⣿⣿⣿⡿⠃  ',
                ' ⠘⣿⣿⣿⣿⣿⣿⣿⣿⡆⠄⠄⠄⠄⠄⠄⠄⠄⠹⠈⢋⣽⣿⣿⣿⣿⣵⣾⠃  ',
                '  ⠘⣿⣿⣿⣿⣿⣿⣿⣿⠄⣴⣿⣶⣄⠄⣴⣶⠄⢀⣾⣿⣿⣿⣿⣿⣿⠃   ',
                '   ⠈⠻⣿⣿⣿⣿⣿⣿⡄⢻⣿⣿⣿⠄⣿⣿⡀⣾⣿⣿⣿⣿⣛⠛⠁    ',
                '     ⠈⠛⢿⣿⣿⣿⠁⠞⢿⣿⣿⡄⢿⣿⡇⣸⣿⣿⠿⠛⠁      ',
                '        ⠉⠻⣿⣿⣾⣦⡙⠻⣷⣾⣿⠃⠿⠋⠁     ⢀⣠⣴ ',
                ' ⣿⣿⣿⣶⣶⣮⣥⣒⠲⢮⣝⡿⣿⣿⡆⣿⡿⠃⠄⠄⠄⠄⠄⠄⠄⣠⣴⣿⣿⣿ ',
                '',
            },
            shortcut = {
                {
                    desc = ' Update Packer',
                    group = '@function',
                    action = 'PackerSync',
                    key = 'q',
                },
                {
                    desc = ' Update Treesitter',
                    group = '@function',
                    action = 'TSUpdate',
                    key = 'w',
                },
                {
                    desc = ' Update Mason',
                    group = '@function',
                    action = 'MasonUpdate',
                    key = 'e',
                },
                {
                    desc = ' Files',
                    group = '@property',
                    action = 'Telescope find_files',
                    key = 'f',
                },
                {
                    desc = ' Search',
                    group = '@property',
                    action = 'Telescope live_grep',
                    key = 's',
                },
            },
        },
    }
end
