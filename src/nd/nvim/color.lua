local fn_lib = require 'nd.lib.core.fn'

local kv     = fn_lib.kv
local each   = fn_lib.each

return function(scheme)
    each(function(elem)
        vim.api.nvim_set_hl(0, elem[1], elem[2])
    end, kv(scheme))
end
