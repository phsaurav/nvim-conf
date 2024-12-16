local map = vim.api.nvim_set_keymap

vim.g.mapleader = " "
vim.keymap.set("i", "kj", "<Esc>")
vim.keymap.set("n", "<leader>eo", vim.cmd.Ex)

-- Normal mode mappings
vim.keymap.set("n", "Q", "gq")
vim.keymap.set("n", "<SPACE>", "<Nop>")
vim.keymap.set("n", "<leader>d", ":nohl<CR>")
vim.keymap.set("n", "d", '"_d')
vim.keymap.set("n", "D", '"_D')
vim.keymap.set("n", "dd", '"_dd')
vim.keymap.set("n", "<leader>n", "/^$/<CR>:nohl<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<leader>s", ":vsplit<CR>")
vim.keymap.set("n", "gh", "_")
vim.keymap.set("n", "gl", "$")
vim.keymap.set("n", "go", "<C-o>")
vim.keymap.set("n", "gi", "<C-i>")
vim.keymap.set("n", "<C-v>", '"+gP', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'L', '16kzz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'H', '16jzz', { noremap = true, silent = true })
map('n', 'gsw', [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], { noremap = true, silent = false })
-- Move to the right split with 'g-j'
vim.keymap.set('n', 'gk', '<C-w>l', { noremap = true, silent = true })

-- Move to the left split with 'g-k'
vim.keymap.set('n', 'gj', '<C-w>h', { noremap = true, silent = true })

-- Visual mode mappings
vim.keymap.set("v", "<Tab>", ">gv")
vim.keymap.set("v", "<S-Tab>", "<gv")
vim.keymap.set("v", "<BS>", "d")
vim.keymap.set("v", "<C-c>", '"+y', { noremap = true, silent = true })
vim.keymap.set("x", "<leader>b", "xi()<Esc>P")
vim.keymap.set("x", "<leader>c", "c{}<Esc>P")
vim.keymap.set("x", "<leader>[", "c[]<Esc>P")
vim.keymap.set("x", "<leader>'", "c''<Esc>P")
vim.keymap.set("x", "<leader>q", 'c""<Esc>P')
vim.api.nvim_set_keymap('v', 'gsw', [[y:%s/<C-r>"//g<Left><Left>]], { noremap = true, silent = false })

-- Common mode mappings
vim.keymap.set({ "n", "v" }, "g;", "%")
vim.keymap.set({ 'n', 'i', 'v', 'c', 't' }, '<C-f>', '<Nop>', { silent = true })


function Save_file()
    local modifiable = vim.api.nvim_buf_get_option(0, 'modifiable')
    if modifiable then
        vim.cmd 'w!'
    end
end

-- Define a toggle function for diagnostic virtual text
local function toggle_virtual_text()
    local current_config = vim.diagnostic.config().virtual_text
    vim.diagnostic.config({ virtual_text = not current_config }) -- Toggle the value
end

-- Create a keymap to toggle virtual text
vim.keymap.set({ 'n', 'v' }, "<leader>wd", toggle_virtual_text, {
    noremap = true,
    silent = true,
})


vim.keymap.set({ 'n', 'v' }, "<leader>w", '<Cmd>lua Save_file()<CR>', {
    noremap = true,
    silent = true,
})

vim.keymap.set({ 'n', 'v' }, "<leader>pb", function()
    vim.cmd("cd ~/Documents/Play_Ground/Blank/")
    print("Directory changed to ~/Documents/Play_Ground/Blank/")
end, {
    noremap = true,
    silent = true,
})

vim.keymap.set('n', '<C-s>', function()
    local save_file = function(path)
        local ok, err = pcall(vim.cmd.w, path)

        if not ok then
            -- clear `vim.ui.input` from cmdline to make space for an error
            vim.cmd.redraw()
            vim.notify(err, vim.log.levels.ERROR, {
                title = 'error while saving file',
            })
        end
    end

    if vim.api.nvim_buf_get_name(0) ~= '' then
        save_file()
    else
        vim.ui.input({ prompt = 'filename: ' }, save_file)
    end
end)

local function quickfix()
    vim.lsp.buf.code_action({
        filter = function(a) return a.isPreferred end,
        apply = true
    })
end

vim.keymap.set('n', '<leader>fx', quickfix, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>wf', "<cmd>lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true })
