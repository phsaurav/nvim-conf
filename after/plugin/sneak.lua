-- Enable label mode
vim.g["sneak#label"] = 1

-- Enable sneak next with 's' and 'S'
vim.g["sneak#s_next"] = 1

-- Enable case-insensitive search
vim.g["sneak#use_ic_scs"] = 1

-- Remove default ',' and ';' keybindings
vim.api.nvim_set_keymap('n', 'T', '<Plug>Sneak_,', {})
vim.api.nvim_set_keymap('n', 't', '<Plug>Sneak_;', {})

-- Set colors for Sneak
vim.cmd([[
  highlight Sneak guifg=black guibg=#00C7DF ctermfg=black ctermbg=cyan
  highlight SneakScope guifg=red guibg=yellow ctermfg=red ctermbg=yellow
]])

-- Set the Sneak prompt
vim.g["sneak#prompt"] = '🔎'


