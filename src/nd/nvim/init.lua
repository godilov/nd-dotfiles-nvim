local packer         = require 'packer'

local fn_lib         = require 'nd.lib.core.fn'
local str_lib        = require 'nd.lib.core.str'

local ivals          = fn_lib.ivals
local map            = fn_lib.map
local collect        = fn_lib.collect

local concat3s       = str_lib.concat3s

local plugin_fn      = require 'nd.resources.core.plugin'

local option_fn      = require 'nd.nvim.option'
local command_fn     = require 'nd.nvim.command'
local navigation_fn  = require 'nd.nvim.navigation'
local development_fn = require 'nd.nvim.development'
local appearance_fn  = require 'nd.nvim.appearance'

local is_init        = false

local concat_elem    = function(elem)
    return concat3s(elem[1], '/', elem[2])
end

return function()
    if not is_init then
        packer.startup {
            collect(map(concat_elem, ivals(plugin_fn()))),
        }

        option_fn()
        command_fn()
        navigation_fn()
        development_fn()
        appearance_fn()

        is_init = true
    end
end
