local fn_lib        = require 'nd.lib.core.fn'

local cache_res     = require 'nd.res.key.cache'
local treeistter_fn = require 'nd.res.core.language.nvim.treesitter'

local lsp_scheme_fn = require 'nd.res.core.language.nvim.lsp'

local key_fn        = require 'nd.nvim.key'

local ivals         = fn_lib.ivals
local mapi          = fn_lib.mapi
local filter        = fn_lib.filter
local collect       = fn_lib.collect
local each          = fn_lib.each

local key_scheme_fn = cache_res.get_nvim

local cmp           = require 'cmp'
local cmp_lsp       = require 'cmp_nvim_lsp'
local snip          = require 'luasnip'

local mason         = require 'mason'
local mason_lsp     = require 'mason-lspconfig'
local lsp           = require 'lspconfig'

local inlayhints    = require 'lsp-inlayhints'

local treesitter    = require 'nvim-treesitter.configs'


local is_not_skip_fn = nil

is_not_skip_fn = function(elem)
    return not elem[2].skip
end

return function(config)
    local key_scheme = key_scheme_fn(config.key)
    local lsp_scheme = lsp_scheme_fn(config.lsp)

    key_fn(key_scheme.lsp_fn())

    vim.diagnostic.config {
        signs            = true,
        underline        = true,
        severity_sort    = true,
        update_in_insert = true,
        virtual_text     = true,
    }

    cmp.setup {
        snippet = {
            expand = function(args)
                snip.lsp_expand(args.body)
            end,
        },
        mapping = key_scheme.cmp_fn(),
        sources = {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'path' },
        },
    }

    inlayhints.setup {
        inlay_hints = {
            highlight = '@type',
        },
    }

    mason.setup {}
    mason_lsp.setup {
        ensure_installed = collect(mapi(1, filter(is_not_skip_fn, ivals(lsp_scheme)))),
    }

    local capabilities = cmp_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

    each(function(elem)
        local key = elem[1]
        local val = elem[2]

        lsp[key].setup {
            settings     = val,
            capabilities = capabilities,
            on_attach    = function(client, bufnr)
                client.server_capabilities.semanticTokensProvider = nil

                vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]

                inlayhints.on_attach(client, bufnr)

                key_fn(key_scheme.lsp_buf_fn(bufnr))
            end,
        }
    end, ivals(lsp_scheme))

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
            keybindings = key_scheme.treesitter_fn(),
        },
    }
end
