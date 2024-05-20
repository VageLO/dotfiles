return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateUp",
    "TmuxNavigateDown",
    "TmuxNavigateRight",
    "TmuxNavigateLeft",
    "TmuxNavigatePrevious",
  },
  keys = {
    { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<CR>" },
    { "<c-l>", "<cmd><C-U>TmuxNavigateRight<CR>" },
    { "<c-j>", "<cmd><C-U>TmuxNavigateDown<CR>" },
    { "<c-k>", "<cmd><C-U>TmuxNavigateUp<CR>" },
  },
}
