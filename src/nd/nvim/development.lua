local fn_lib        = require 'nd.lib.core.fn'

local cache_res     = require 'nd.resources.key.cache'
local treeistter_fn = require 'nd.resources.core.language.nvim.treesitter'
local lsp_fn        = require 'nd.resources.core.language.nvim.lsp'

local key_fn        = require 'nd.nvim.key'

local kv            = fn_lib.kv
local mapi          = fn_lib.mapi
local filter        = fn_lib.filter
local collect       = fn_lib.collect
local each          = fn_lib.each

local scheme_fn     = cache_res.get_nvim

local mason         = require 'mason'
local mason_lsp     = require 'mason-lspconfig'
local config        = require 'lspconfig'

local cmp           = require 'cmp'
local cmp_lsp       = require 'cmp_nvim_lsp'
local snip          = require 'luasnip'

local treesitter    = require 'nvim-treesitter.configs'


local is_not_skip_fn = nil

is_not_skip_fn = function(elem)
    return not elem[2].skip
end

return function(key_config, lsp_config)
    local scheme  = scheme_fn(key_config)
    local servers = lsp_fn(lsp_config)

    key_fn(scheme.editor_fn())

    vim.diagnostic.config {
        signs            = true,
        underline        = true,
        severity_sort    = true,
        update_in_insert = true,
        virtual_text     = false,
    }

    cmp.setup {
        snippet = {
            expand = function(args)
                snip.lsp_expand(args.body)
            end,
        },
        mapping = scheme.cmp_fn(),
        sources = {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'path' },
        },
    }

    mason.setup {}
    mason_lsp.setup {
        ensure_installed = collect(mapi(1, filter(is_not_skip_fn, kv(servers)))),
    }

    local capabilities = cmp_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

    each(function(elem)
        local key = elem[1]
        local val = elem[2]

        config[key].setup {
            settings     = val,
            capabilities = capabilities,
            on_attach    = function(_, bufnr)
                key_fn(scheme.lsp_buf_fn(bufnr))
            end,
        }
    end, kv(servers))

    treesitter.setup {
        ensure_installed = treeistter_fn(),
        highlight = {
            enable = true,
        },
        playground = {
            enable = true,
            disable = {},
            updatetime = 25,
            persist_queries = false,
            keybindings = scheme.treesitter_fn(),
        },
    }
end
