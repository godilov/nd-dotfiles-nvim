local cache_res = require 'nd.resources.key.cache'

local key_fn    = require 'nd.nvim.key'

local scheme_fn = cache_res.get_nvim

local tree      = require 'nvim-tree'
local telescope = require 'telescope'

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
end
