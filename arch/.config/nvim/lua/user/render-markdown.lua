local M = {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown' },  -- 在打开 markdown 文件时加载
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'echasnovski/mini.nvim',  -- 修正依赖项名称
    },
    opts = {},  -- 使用默认配置，lazy.nvim 会自动调用 setup()
}

return M
