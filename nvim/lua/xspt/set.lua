-- vim.opt.etc = x
local options = {
   backup = false,
   nu = true, -- line numbers
   relativenumber = true, -- relative line numbers
   -- identation related
   tabstop = 8,
   softtabstop = 8,
   shiftwidth = 8,
   expandtab = true,
   smartindent = true,
   --
   wrap = false, -- word wrap
   hlsearch = false, -- highlighting search occurences
   incsearch = true,
   scrolloff = 10,
   sidescrolloff = 10,
   cursorline = true, -- highlight the line cursor is in
   splitbelow = true,
   splitright = true,
   swapfile = false,
   mouse = "", -- disables mouse
   termguicolors = true,
}

-- disables netrw (nvimtree compatibility)
vim.g.netrw_keepdir = 0
vim.g.netrw_banner = 0

for k, v in pairs(options) do
   vim.opt[k] = v
end
