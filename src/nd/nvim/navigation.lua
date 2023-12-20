local str_lib         = require 'nd.lib.core.str'

local key_cache_res   = require 'nd.res.key.cache'
local color_cache_res = require 'nd.res.color.cache'

local key_fn          = require 'nd.nvim.key'

local concat2s        = str_lib.concat2s

local key_scheme_fn   = key_cache_res.get_nvim
local color_scheme_fn = color_cache_res.get_nvim

local tree            = require 'nvim-tree'
local telescope       = require 'telescope'
local sessions        = require 'sessions'
local workspaces      = require 'workspaces'

return function(config)
    local key_scheme   = key_scheme_fn(config.key)
    local color_scheme = color_scheme_fn(config.color)

    key_fn(key_scheme.editor_fn())

    tree.setup {
        on_attach = function(bufnr)
            key_fn(key_scheme.tree_fn(bufnr))
        end,
        view = {
            width = 48,
        },
        renderer = {
            icons = color_scheme.etc.tree.icons,
        },
    }

    telescope.setup {
        defaults = {
            borderchars = color_scheme.etc.telescope.borderchars,
            mappings = key_scheme.telescope_fn(),
        },
    }

    sessions.setup {
        session_filepath = '.session',
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
