local oil = require("oil")

oil.setup({
   view_options = {
      show_hidden = true,
   },
})

vim.keymap.set('n', '<leader>e', function() oil.toggle_float() end, {})
