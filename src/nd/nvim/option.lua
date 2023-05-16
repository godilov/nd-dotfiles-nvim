return function()
    vim.opt.encoding      = 'utf-8'
    vim.opt.splitright    = true
    vim.opt.splitbelow    = true
    vim.opt.autowrite     = true
    vim.opt.autowriteall  = true
    vim.opt.termguicolors = true
    vim.opt.showmode      = false
    vim.opt.signcolumn    = 'yes'
    vim.opt.mouse         = ''

    vim.cmd 'nohlsearch'

    vim.opt.laststatus  = 2
    vim.opt.tabstop     = 4
    vim.opt.softtabstop = 4
    vim.opt.shiftwidth  = 4
    vim.opt.shiftround  = true
    vim.opt.smarttab    = true
    vim.opt.expandtab   = true
    vim.opt.autoindent  = true
    vim.opt.smartindent = true

    vim.opt.hlsearch    = true
    vim.opt.incsearch   = true
    vim.opt.smartcase   = true
    vim.opt.gdefault    = true

    vim.opt.lazyredraw  = true
    vim.opt.updatetime  = 500
end
