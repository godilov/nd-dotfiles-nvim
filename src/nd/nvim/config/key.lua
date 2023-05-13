local cmp       = require 'cmp'
local snip      = require 'luasnip'
local tree      = require 'nvim-tree'
local telescope = require 'telescope'
local actions   = require 'telescope.actions'

return {
    ['main'] = {
        scheme = 'main',
        leader = {
            files    = ';',
            lsp_goto = 'g',
            lsp      = ' ',
        },
        opts = {
            noremap = true,
        },
        api = {
            nvim      = vim,
            cmp       = cmp,
            snip      = snip,
            tree      = tree,
            telescope = telescope,
            actions   = actions,
        },
    },
}
