return {
    -- 1. nvim-lspconfig (Language Server Protocol Client)
    {
        "neovim/nvim-lspconfig",
        -- autostart = true, -- autostart isn't a valid option for nvim-lspconfig directly,
                            -- servers start when the filetype matches.
                            -- remove this line, it doesn't do anything.
        config = function()
            local lspconfig = require("lspconfig")

            -- Basic on_attach function to set up common LSP keymaps
            -- This is where you would put your LSP-specific keybindings
            local on_attach = function(client, bufnr)
                -- Enable completion capabilities (important for nvim-cmp to work with LSP)
                -- Note: nvim-cmp usually handles this implicitly when it's setup
                -- but explicitly setting capabilities can sometimes help.
                -- However, for basic setup, nvim-cmp's default capabilities are often fine.

                -- Keybindings for common LSP features (adjust as needed)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = "LSP Go to Definition" })
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, desc = "LSP Go to References" })
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP Hover Documentation" })
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr, desc = "LSP Rename Symbol" })
                vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = "LSP Code Action" })
                vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, { buffer = bufnr, desc = "LSP Format Code" })
                -- Add more as you learn them!
            end

            -- Setup each LSP server
            lspconfig.ts_ls.setup{ on_attach = on_attach }
            lspconfig.rust_analyzer.setup{ on_attach = on_attach }
            lspconfig.vimls.setup{ on_attach = on_attach }
            lspconfig.bashls.setup{ on_attach = on_attach }
            lspconfig.jsonls.setup{ on_attach = on_attach }
            lspconfig.yamlls.setup{ on_attach = on_attach }
            lspconfig.html.setup{ on_attach = on_attach }
            lspconfig.cssls.setup{ on_attach = on_attach }
            lspconfig.vuels.setup{ on_attach = on_attach }
            lspconfig.jdtls.setup{ on_attach = on_attach }
            lspconfig.pyright.setup{ on_attach = on_attach }
        end,
    },

    -- 2. nvim-cmp (Autocompletion Framework)
    {
        "hrsh7th/nvim-cmp",
        -- Make sure it runs after other required plugins are loaded
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lua", -- Correct source name for nvim_lua
            "hrsh7th/cmp_luasnip",  -- Correct plugin for luasnip integration
            "L3MON4D3/LuaSnip",     -- The snippet engine itself
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip") -- Make sure LuaSnip is loaded

            cmp.setup({
                -- Setup snippet expansion for nvim-cmp to use LuaSnip
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                -- Keymappings for navigation and acceptance!
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(), -- Manually trigger completion
                    ['<C-e>'] = cmp.mapping.abort(),        -- Abort completion
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item (default Enter)

                    -- TAB for selection and snippets
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jumpable()
                        else
                            fallback() -- Fallback to default Neovim tab behavior
                        end
                    end, { 'i', 's' }), -- 'i' for insert mode, 's' for select mode (for snippets)

                    -- SHIFT-TAB for previous item/snippet
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then -- Jump to previous snippet placeholder
                            luasnip.jumpable(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },     -- Language Server Protocol
                    { name = "luasnip" },      -- Snippets (requires cmp_luasnip and LuaSnip)
                    { name = "buffer" },       -- Words from current buffer
                    { name = "path" },         -- File paths
                    { name = "nvim_lua" },     -- Neovim's Lua API (for Lua files)
                    -- Add other sources you might want, e.g., { name = "cmdline" } for cmdline mode
                }),
            })
        end,
    },

    -- 3. nvim-cmp Sources (plugins providing completion data)
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-nvim-lua" }, -- Add this for Lua completion (from your sources list)
    { "hrsh7th/cmp_luasnip" },  -- nvim-cmp integration with LuaSnip

    -- 4. LuaSnip (Snippet Engine)
    {
        'L3MON4D3/LuaSnip',
        -- Build command for LuaSnip (important for some features)
        build = "make install_jsregexp" -- or 'make install_bin' depending on your needs
    },
}
