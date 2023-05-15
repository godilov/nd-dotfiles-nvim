local fn_lib   = require 'nd.lib.core.fn'
local str_lib  = require 'nd.lib.core.str'

local kv       = fn_lib.kv
local map      = fn_lib.map
local collect  = fn_lib.collect

local concat2s = str_lib.concat2s

local format   = string.format

local concat   = table.concat


local as_str = nil

as_str = function(key, val)
    local link = val[5]

    if not link then
        return format('%s guifg=%s guibg=%s guisp=%s gui=%s',
            key,
            val[1] or 'NONE',
            val[2] or 'NONE',
            val[3] or 'NONE',
            val[4] or 'NONE')
    else
        return format('link %s %s', key, link or 'NONE')
    end
end

return function(scheme)
    vim.cmd(concat2s(':', concat(collect(map(function(elem)
        local key = elem[1]
        local val = elem[2]

        return format('highlight %s', as_str(key, val))
    end, kv(scheme))), ' | ')))
end
