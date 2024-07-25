return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
        { "<leader>to", "<cmd>TodoTelescope<cr>", desc = "Todo (Telescope)" }
    }
}
