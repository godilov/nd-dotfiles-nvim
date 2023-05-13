local fn_lib = require 'nd.lib.core.fn'

local kv     = fn_lib.kv
local each   = fn_lib.each

return function(scheme)
    each(function(key, desc)
        vim.api.nvim_set_hl(0, key, desc)
    end, kv(scheme))
end
