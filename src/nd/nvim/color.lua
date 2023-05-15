local fn_lib   = require 'nd.lib.core.fn'
local str_lib  = require 'nd.lib.core.str'

local ivals    = fn_lib.ivals
local map      = fn_lib.map
local collect  = fn_lib.collect

local concat2s = str_lib.concat2s

local format   = string.format

local concat   = table.concat


local as_str = nil

as_str = function(val)
    local link = val[6]

    if not link then
        return format('%s guifg=%s guibg=%s guisp=%s gui=%s',
            val[1],
            val[2],
            val[3],
            val[4],
            val[5])
    else
        return format('link %s %s', val[1], link)
    end
end

return function(scheme)
    vim.cmd(concat2s(':', concat(collect(map(function(val)
        return format('highlight %s', as_str(val))
    end, ivals(scheme))), ' | ')))
end
