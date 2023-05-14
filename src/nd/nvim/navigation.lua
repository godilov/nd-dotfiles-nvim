local str_lib    = require 'nd.lib.core.str'

local cache_res  = require 'nd.res.key.cache'

local key_fn     = require 'nd.nvim.key'

local concat2s   = str_lib.concat2s

local scheme_fn  = cache_res.get_nvim

local tree       = require 'nvim-tree'
local telescope  = require 'telescope'
local startup    = require 'startup'
local sessions   = require 'sessions'
local workspaces = require 'workspaces'

return function(key_config)
    local scheme = scheme_fn(key_config)

    key_fn(scheme.editor_fn())

    tree.setup {
        on_attach = function(bufnr)
            key_fn(scheme.tree_fn(bufnr))
        end,
        view = {
            float = {
                enable = true,
                open_win_config = {
                    border = 'single',
                    width  = 64,
                    height = 256,
                },
            },
        },
    }

    telescope.setup {
        defaults = {
            borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
            mappings = scheme.telescope_fn(),
        },
    }

    startup.setup {
        theme = 'evil',
    }

    sessions.setup {
        session_filepath = '.session',
        -- session_filepath = concat2s(vim.fn.stdpath 'data', '/sessions'),
        -- absolute = true,
    }

    workspaces.setup {
        path = concat2s(vim.fn.stdpath 'data', '/workspaces'),
        hooks = {
            open = function()
                sessions.load(nil, { silent = true })
            end,
        },
    }

    telescope.load_extension 'workspaces'
end
