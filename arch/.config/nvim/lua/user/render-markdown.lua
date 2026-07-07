local M = {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown' },  -- 在打开 markdown 文件时加载
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'echasnovski/mini.nvim',  -- 修正依赖项名称
    },
    opts = {
        -- 关掉 anti-conceal：光标所在行也保持渲染，不再揭示成原始文本
        anti_conceal = { enabled = false },
    },
}

return M
