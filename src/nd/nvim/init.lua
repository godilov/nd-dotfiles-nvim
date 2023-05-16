local fn_lib         = require 'nd.lib.core.fn'
local str_lib        = require 'nd.lib.core.str'
local cache_lib      = require 'nd.lib.cache.fs'

local plugin_fn      = require 'nd.res.core.plugin'

local key_config     = require 'nd.nvim.config.key'
local color_config   = require 'nd.nvim.config.color'
local lsp_config     = require 'nd.nvim.config.lsp'

local option_fn      = require 'nd.nvim.option'
local command_fn     = require 'nd.nvim.command'
local navigation_fn  = require 'nd.nvim.navigation'
local development_fn = require 'nd.nvim.development'
local appearance_fn  = require 'nd.nvim.appearance'

local ivals          = fn_lib.ivals
local map            = fn_lib.map
local collect        = fn_lib.collect

local concat2s       = str_lib.concat2s
local concat3s       = str_lib.concat3s

local packer         = require 'packer'

local is_init        = false

local concat_elem    = nil


concat_elem = function(elem)
    return concat3s(elem[1], '/', elem[2])
end

return function()
    if not is_init then
        cache_lib.set_dir(concat2s(vim.fn.stdpath 'cache', '/nd.nvim/'))

        local plugins = plugin_fn()

        packer.startup {
            collect(map(concat_elem, ivals(plugins))),
        }

        local config = {
            key   = key_config['main'],
            color = color_config['main'],
            lsp   = lsp_config['main'],
        }

        option_fn()
        command_fn(config)
        navigation_fn(config.key)
        development_fn(config.key, config.lsp)
        appearance_fn(config.color)

        is_init = true
    end
end
