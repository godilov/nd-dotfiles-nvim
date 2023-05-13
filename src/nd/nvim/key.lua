local fn_lib = require 'nd.lib.core.fn'

local ivals  = fn_lib.ivals
local each   = fn_lib.each

return function(scheme)
    each(function(desc)
        vim.keymap.set(desc[1], desc[2], desc[3], desc[4])
    end, ivals(scheme))
end
