-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
    '3rd/image.nvim', -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  lazy = false,
  cmd = 'Neotree',
  config = function()
    require('neo-tree').setup {
      close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
      filesystem = {
        filtered_items = {
          visible = false, -- when true, they will just be displayed differently than normal items
          always_show = { -- remains visible even if other settings would normally hide it
            '.gitignore',
            '.gitlab-ci.yaml',
            '.gitlab-ci.yml',
          },
          always_show_by_pattern = { -- uses glob style patterns
            '.env*',
          },
        },
      },
    }
    vim.keymap.set('n', '<leader>Nt', '<cmd>Neotree toggle<CR>', { desc = '[N]eotree [t]oggle', noremap = true })
    vim.keymap.set('n', '<leader>Nr', function()
      local reveal_file = vim.fn.expand '%:p'
      if reveal_file == '' then
        reveal_file = vim.fn.getcwd()
      else
        local f = io.open(reveal_file, 'r')
        if f then
          f.close(f)
        else
          reveal_file = vim.fn.getcwd()
        end
      end
      require('neo-tree.command').execute {
        action = 'focus', -- OPTIONAL, this is the default value
        source = 'filesystem', -- OPTIONAL, this is the default value
        position = 'left', -- OPTIONAL, this is the default value
        reveal_file = reveal_file, -- path to file or folder to reveal
        reveal_force_cwd = true, -- change cwd without asking if needed
      }
    end, { desc = '[N]eotree [r]eveal' })
  end,
}
