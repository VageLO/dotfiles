return {
  'tris203/precognition.nvim',
  event = 'VeryLazy',
  --  enabled = false,
  opts = {
    startVisible = true,
  },
  keys = {
    {
      '<leader>pr',
      function()
        require('precognition').toggle()
      end,
    },
  },
}
