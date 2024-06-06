return {
  'akinsho/flutter-tools.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local telescope = require 'telescope'
    telescope.load_extension 'flutter'
    -- telescope.extensions.flutter.commands()
    vim.keymap.set('n', '<leader>Fc', '<cmd>Telescope flutter commands<cr>', { desc = 'Display available flutter commands', noremap = true })
  end,
}
