local option_fn      = require 'nd.nvim.option'
local command_fn     = require 'nd.nvim.command'
local navigation_fn  = require 'nd.nvim.navigation'
local appearance_fn  = require 'nd.nvim.appearance'
local development_fn = require 'nd.nvim.development'

local is_init        = false

return function()
    if not is_init then
        option_fn()
        command_fn()
        navigation_fn()
        appearance_fn()
        development_fn()

        is_init = true
    end
end
