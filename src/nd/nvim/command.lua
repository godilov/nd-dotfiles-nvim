local fn_lib   = require 'nd.lib.core.fn'

local key_fn   = require 'nd.nvim.key'
local color_fn = require 'nd.nvim.color'

local keys     = fn_lib.keys
local ivals    = fn_lib.ivals
local filter   = fn_lib.filter
local each     = fn_lib.each

local format   = string.format
local match    = string.match
local gsub     = string.gsub


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

nd_apply_config = function(key_config, color_config)
    return function()
        vim.cmd 'wa'

        unload {
            -- TODO: check if needed to unload cache

            'nd.resources.key.cache',
            'nd.resources.color.cache',
            'nd.resources.core.key.nvim',
            'nd.resources.core.color.nvim',
        }

        local key_res      = require 'nd.resources.key.cache'
        local color_res    = require 'nd.resources.color.cache'

        local key_scheme   = key_res.get_nvim(key_config, true)
        local color_scheme = color_res.get_nvim(color_config, true)

        key_fn(key_scheme.editor_fn())
        color_fn(color_scheme.highlight)

        print 'Config has been applied!'
    end
end

nd_apply_file = function()
    return function()
        vim.cmd 'wa'
        vim.cmd 'source %'

        print 'File has been applied!'
    end
end

return function(key_config, color_config)
    vim.api.nvim_create_user_command('NdApplyConfig', nd_apply_config(key_config, color_config), {})
    vim.api.nvim_create_user_command('NdApplyFile', nd_apply_file(), {})
end
