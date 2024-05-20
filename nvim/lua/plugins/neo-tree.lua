return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      disable_netrw = true,
      hijack_netrw = true,
      open_on_setup = false,
      ignore_ft_on_setup = {},
      double_exit = false,
    })
  end,

  -- Fully disable autostart event on "nvim ."
  --{
  --  "nvim-neo-tree/neo-tree.nvim",
  --  init = function()
  --  end,
  --},
}
