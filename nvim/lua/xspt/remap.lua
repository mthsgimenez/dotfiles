local keyset = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- move selection up/down in visual mode
keyset("v", "J", ":m '>+1<CR>gv=gv")
keyset("v", "K", ":m '>-2<CR>gv=gv")

-- half page navigation with cursor centered
keyset("n", "<C-d>", "<C-d>zz")
keyset("n", "<C-u>", "<C-u>zz")

-- center screen on search result
keyset("n", "n", "nzzzv")
keyset("n", "N", "Nzzzv")

-- paste without writing the overwrited text to the register
keyset("x", "<leader><C-p>", "\"_dP")

-- yank to system clipboard
keyset("n", "<leader>y", "\"+y")
keyset("v", "<leader>y", "\"+y")
keyset("n", "<leader>Y", "\"+Y")

-- delete to void (without writing to the register)
keyset("n", "<leader>d", "\"_d")
keyset("v", "<leader>d", "\"_d")

-- substitute in whole document
keyset("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- chmod +x current file
keyset("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- window navigation
-- keyset("n", "<C-h>", "<C-w>h")
-- keyset("n", "<C-j>", "<C-w>j")
-- keyset("n", "<C-k>", "<C-w>k")
-- keyset("n", "<C-l>", "<C-w>l")

-- window resizing
keyset("n", "<A-h>", ":vertical resize -2<CR>")
keyset("n", "<A-j>", ":resize -2<CR>")
keyset("n", "<A-k>", ":resize +2<CR>")
keyset("n", "<A-l>", ":vertical resize +2<CR>")

-- stay in indent mode
keyset("v", ">", ">gv")
keyset("v", "<", "<gv")

-- buffers
keyset("n", "<leader><S-h>", ":bp<CR>")
keyset("n", "<leader><S-l>", ":bn<CR>")
keyset("n", "<leader><S-w>", ":bd<CR>")

-- terminal
keyset("t", "<Esc>", "<C-\\><C-n>")
