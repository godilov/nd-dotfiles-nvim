local packer         = require 'packer'

local fn_lib         = require 'nd.lib.core.fn'
local str_lib        = require 'nd.lib.core.str'
local tab_lib        = require 'nd.lib.core.tab'

local plugin_fn      = require 'nd.resources.core.plugin'

local key_config     = require 'nd.nvim.config.key'
local color_config   = require 'nd.nvim.config.color'

local option_fn      = require 'nd.nvim.option'
local command_fn     = require 'nd.nvim.command'
local navigation_fn  = require 'nd.nvim.navigation'
local development_fn = require 'nd.nvim.development'
local appearance_fn  = require 'nd.nvim.appearance'

local ivals          = fn_lib.ivals
local map            = fn_lib.map
local collect        = fn_lib.collect

local concat3s       = str_lib.concat3s

local concat         = tab_lib.concat

local is_init        = false

local concat_elem    = nil
local concat_lib     = nil


concat_elem = function(elem)
    return concat3s(elem[1], '/', elem[2])
end

concat_lib = function(elem)
    return concat3s(packer.config.package_root, '/packer/start/', elem[2])
end

return function()
    if not is_init then
        local plugin_iter = ivals(plugin_fn())

        packer.startup {
            collect(map(concat_elem, plugin_iter)),
        }

        local key_cfg   = key_config['main']
        local color_cfg = color_config['main']
        local lsp_cfg   = {
            lua = {
                libs = concat {
                    collect(map(concat_lib, plugin_iter)),
                    {
                        '/usr/share/nvim/runtime/lua',
                        '/usr/share/nvim/runtime/lua/lsp',
                        '/usr/share/awesome/lib',
                    },
                },
                globals = {
                    'vim',
                    'awesome',
                    'screen',
                    'client',
                    'root',
                },
            },
        }

        option_fn()
        command_fn(key_cfg, color_cfg)
        navigation_fn(key_cfg)
        development_fn(key_cfg, lsp_cfg)
        appearance_fn(color_cfg)

        is_init = true
    end
end
