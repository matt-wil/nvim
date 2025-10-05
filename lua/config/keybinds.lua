-- Set the leader key to a space. Must be before any leader keymaps.
vim.g.mapleader = " "

-- === Navigation & Editing ===
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Project/File Explorer" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Line Down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Line Up" })

-- Keep cursor centered when navigating
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join Lines" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Page Down (Centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Page Up (Centered)" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next Search (Centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous Search (Centered)" })

-- === Clipboard & Deletion ===
-- Actions that don't affect the clipboard register
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste (No Yank)" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete (No Yank)" })

-- Yank to system clipboard (works over SSH)
vim.keymap.set("n", "<leader>y", "<Plug>OSCYankOperator", { desc = "Yank (OSC)" })
vim.keymap.set("v", "<leader>y", "<Plug>OSCYankVisual", { desc = "Yank Visual (OSC)" })

-- === Quality of Life ===
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Map Ctrl-C to Escape" })
vim.keymap.set("n", "Q", "<nop>", { desc = "Disable Ex Mode" })
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle Undotree" })

-- Find and replace word under cursor
vim.keymap.set("n", "<leader>s", [[:s/\<<C-r><C-w>\>//gI<Left><Left><Left>]], { desc = "Substitute Word" })

-- === Quickfix & Location Lists ===
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz", { desc = "Quickfix Next" })
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz", { desc = "Quickfix Previous" })
vim.keymap.set("n", "<leader>co", ":copen<CR>", { desc = "Open Quickfix List", silent = true })
vim.keymap.set("n", "<leader>cl", ":cclose<CR>", { desc = "Close Quickfix List", silent = true })

vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Location List Previous" })
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Location List Next" })
vim.keymap.set("n", "<leader>li", ":checkhealth vim.lsp<CR>", { desc = "LSP Info" })

-- === File & System ===
vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end, { desc = "Source Current File" })

vim.keymap.set("n", "<leader>rl", "<cmd>Lazy<cr>", { desc = "Reload Config (Lazy)" })vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "Make File Executable", silent = true })

-- === Plugin / External Tools ===
vim.keymap.set("n", "<leader>dg", "<cmd>DogeGenerate<cr>", { desc = "Generate Docblocks (Doge)" })
vim.keymap.set("n", "<leader>cc", "<cmd>!php-cs-fixer fix % --using-cache=no<cr>", { desc = "Fix PHP Coding Standards" })
