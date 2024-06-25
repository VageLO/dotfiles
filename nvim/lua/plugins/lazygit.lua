return {
  'kdheepak/lazygit.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim'
  },
    keys = {
        { "<leader>lg", mode={ "n" }, "<cmd>LazyGit<cr>", desc = "Lazy Git" }
    }
}
