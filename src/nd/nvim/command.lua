local fn_lib = require 'nd.lib.core.fn'

local keys   = fn_lib.keys
local ivals  = fn_lib.ivals
local filter = fn_lib.filter
local each   = fn_lib.each

local format = string.format
local match  = string.match
local gsub   = string.gsub


local unload          = nil
local nd_apply_config = nil
local nd_apply_file   = nil


unload = function(mods)
    each(function(mod)
        each(function(name)
            package.loaded[name] = nil
        end, filter(function(name)
            return match(name, format('^%s', gsub(mod, '%.', '%.')))
        end, keys(package.loaded)))
    end, ivals(mods))
end

nd_apply_config = function()
    vim.cmd 'wa'

    unload {
        'nd.resources.core.key.nvim',
        'nd.resources.core.color.nvim',
    }

    local key_fn   = require 'nd.nvim.key'
    local color_fn = require 'nd.nvim.color'

    key_fn {}
    color_fn {
        cache = {
            forced = true,
        },
    }

    print 'Config has been applied!'
end

nd_apply_file = function()
    vim.cmd 'wa'
    vim.cmd 'source %'

    print 'File has been applied!'
end

return function()
    vim.api.nvim_create_user_command('NdApplyConfig', nd_apply_config, {})
    vim.api.nvim_create_user_command('NdApplyFile', nd_apply_file, {})
end
