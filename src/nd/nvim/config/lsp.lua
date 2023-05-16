return {
    ['main'] = {
        lua = {
            libs = {
                '/usr/share/nvim/runtime/lua',
                '/usr/share/nvim/runtime/lua/lsp',
                '/usr/share/awesome/lib',
            },
            globals = {
                'vim',
                'awesome',
                'screen',
                'client',
                'root',
            },
        },
    },
}
