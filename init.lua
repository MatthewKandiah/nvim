vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.hlsearch = false
vim.o.incsearch = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.scrolloff = 12
vim.o.mouse = 'a'
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.smarttab = true
vim.o.expandtab = false
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.wo.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true
vim.wo.linebreak = true
vim.o.cursorline = true

-- bootstrap package manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	}
end
vim.opt.rtp:prepend(lazypath)

-- install plugins
require('lazy').setup({
	'neovim/nvim-lspconfig',
	'navarasu/onedark.nvim',
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim' },
	},
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'make',
		cond = function()
			return vim.fn.executable 'make' == 1
		end,
	},
	'folke/lua-dev.nvim',
	'folke/neodev.nvim',
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/nvim-cmp',
	'L3MON4D3/LuaSnip',
	'saadparwaiz1/cmp_luasnip',
	{
		'nvim-treesitter/nvim-treesitter',
		dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
		build = ':TSUpdate',
	},
	{ 'folke/which-key.nvim', opts = {} },
	{
		'numToStr/Comment.nvim',
		opts = {},
		lazy = false,
	},
	'tpope/vim-fugitive',
	'lewis6991/gitsigns.nvim',
	{
		'stevearc/oil.nvim',
		opts = {},
		-- Optional dependencies
		-- dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	'mfussenegger/nvim-dap',
	'rcarriga/nvim-dap-ui',
	'mbbill/undotree',
	'hiphish/rainbow-delimiters.nvim',
}, {})

-- copy to clipboard and selection registers
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')
vim.keymap.set({ 'n', 'v' }, '<leader>Y', '"+Y')
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p')
vim.keymap.set({ 'n', 'v' }, '<leader>P', '"+P')
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"*y')
vim.keymap.set({ 'n', 'v' }, '<leader>Y', '"*Y')
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"*p')
vim.keymap.set({ 'n', 'v' }, '<leader>P', '"*P')
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
-- yank group highlight
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = '*',
})
-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', '<Up>', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', '<Down>', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- move line commands, stolen from ThePrimeagen
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('v', '<S-Up>', ":m '<-2<CR>gv=gv")
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', '<S-Down>', ":m '>+1<CR>gv=gv")
-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
-- Undo tree
vim.keymap.set('n', '<leader>u', ":UndotreeToggle<CR>", { desc = 'Toggle undo tree' })

-- telescope config
-- search hidden files, but still ignore .git files https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#file-and-text-search-in-hidden-files-and-directories
local vimgrep_arguments = { unpack(require("telescope.config").values.vimgrep_arguments) }
table.insert(vimgrep_arguments, "--hidden")
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")
require('telescope').setup({
	defaults = {
		layout_strategy = 'vertical',
		layout_config = { height = 0.95 },
		vimgrep_arguments = vimgrep_arguments,
		path_display = {
			truncate = 3
		},
	},
	pickers = {
		find_files = {
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
		},
	},
})
pcall(require('telescope').load_extension, 'fzf')
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', function()
	require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
		winblend = 10,
		previewer = false,
	})
end, { desc = '[ ] Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>s~', function()
	require('telescope.builtin').find_files({ cwd = vim.env.HOME })
end, { desc = '[S]earch [~] Directory' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- autocompletion config
local cmp = require('cmp')
cmp.setup({
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	})
})

-- lsp config
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local on_attach = function(_, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = 'LSP: ' .. desc
		end

		vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
	end
	nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
	nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
	nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
	nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
	nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
	nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
	nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
	vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
		vim.lsp.buf.format()
	end, { desc = 'Format current buffer with LSP' })
end

local lspconfig = require('lspconfig')
local default_lsp_options = {
	on_attach = on_attach,
	capabilities = capabilities,
}
-- requires lua-language-server on path
lspconfig.lua_ls.setup({
	-- extra setup for better neovim package development support, copied from lspconfig's documentation
	on_init = function(client)
		local path = client.workspace_folders[1].name
		if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
			client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
				Lua = {
					runtime = {
						version = 'LuaJIT'
					},
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME
						}
					}
				}
			})

			client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
		end
		return true
	end,
	on_attach = on_attach,
	capabilities = capabilities,
})
-- requires rust-analyzer on path
lspconfig.rust_analyzer.setup(default_lsp_options)
-- requires gopls on path
lspconfig.gopls.setup(default_lsp_options)
-- requires typescript and tsserver on path
lspconfig.tsserver.setup({
	capabilities = capabilities,
	on_attach = function(_, bufnr)
		on_attach(_, bufnr)
		vim.o.tabstop = 2
		vim.o.softtabstop = 2
		vim.o.shiftwidth = 2
	end
})
-- requires vscode-css-language-server on path
lspconfig.cssls.setup(default_lsp_options)
-- requires cssmodules-language-server on path
lspconfig.cssmodules_ls.setup(default_lsp_options)
-- requires dart on path
lspconfig.dartls.setup(default_lsp_options)
-- requires clangd on path
lspconfig.clangd.setup(default_lsp_options)
-- requires cmake-language-server on path
lspconfig.cmake.setup(default_lsp_options)
-- requires zls on path
lspconfig.zls.setup(default_lsp_options)
-- requires marksman on path
lspconfig.marksman.setup(default_lsp_options)
-- requires racket-langserver installed with `raco`, and `racket` on path
lspconfig.racket_langserver.setup(default_lsp_options)

-- treesitter config
vim.defer_fn(function()
	require('nvim-treesitter.configs').setup {
		rainbow = { enable = true },
		ensure_installed = { 'lua' },
		auto_install = true,
		highlight = { enable = true },
		indent = { enable = true },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = '<c-space>',
				node_incremental = '<c-space>',
				scope_incremental = '<c-s>',
				node_decremental = '<M-space>',
			},
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					['aa'] = '@parameter.outer',
					['ia'] = '@parameter.inner',
					['af'] = '@function.outer',
					['if'] = '@function.inner',
					['ac'] = '@class.outer',
					['ic'] = '@class.inner',
				},
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					[']m'] = '@function.outer',
					[']]'] = '@class.outer',
				},
				goto_next_end = {
					[']M'] = '@function.outer',
					[']['] = '@class.outer',
				},
				goto_previous_start = {
					['[m'] = '@function.outer',
					['[['] = '@class.outer',
				},
				goto_previous_end = {
					['[M'] = '@function.outer',
					['[]'] = '@class.outer',
				},
			},
			swap = {
				enable = true,
				swap_next = {
					['<leader>a'] = '@parameter.inner',
				},
				swap_previous = {
					['<leader>A'] = '@parameter.inner',
				},
			},
		},
	}
end, 0)

-- theme config
local theme = require('onedark')
theme.setup {
	style = 'darker',
	ending_tildes = true,
}
theme.load()

-- git signs config
require('gitsigns').setup()

-- file explorer
local oil = require('oil')
local oil_actions = require('oil.actions')
oil.setup()
vim.keymap.set('n', '<leader>o', oil.open)
vim.keymap.set('n', '<leader>_', oil_actions.open_cwd.callback)

-- dap config
require('neodev').setup({
	library = {
		plugins = {
			{ 'nvim-dap-ui' }, types = true,
		}
	}
})
local dap = require('dap')
local dapui = require('dapui')
dapui.setup({
	layouts = {
		{
			elements = { {
				id = 'breakpoints',
				size = 0.25,
			}, {
				id = 'watches',
				size = 0.75,
			}, },
			position = 'left',
			size = 40,
		},
	},
	icons = {
		collapsed = '>',
		expanded = 'V',
		current_frame = 'O',
	},
})
dap.listeners.after.event_initialized['dapui_config'] = function()
	dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
	dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
	dapui.close()
end
dap.adapters.codelldb = {
	type = 'server',
	port = '${port}',
	executable = {
		-- requires codelldb executable at the specified absolute path
		command = '/usr/bin/codelldb',
		args = { '--port', '${port}' },
	}
}
dap.configurations.rust = {
	{
		name = 'Launch file',
		type = 'codelldb',
		request = 'launch',
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = false,
	}
}
vim.keymap.set('n', '<leader>dd', dap.continue)
vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint)
vim.keymap.set('n', '<F1>', dap.step_out)
vim.keymap.set('n', '<F2>', dap.step_over)
vim.keymap.set('n', '<F3>', dap.step_into)
