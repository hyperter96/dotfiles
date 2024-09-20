-- This is the same as in lspconfig.server_configurations.jdtls, but avoids
-- needing to require that when this module loads.
local java_filetypes = { "java" }
local java_cmds = vim.api.nvim_create_augroup("java_cmds", { clear = true })

-- Utility function to extend or override a config table, similar to the way
-- that Plugin.opts works.
---@param config table
---@param custom function | table | nil
local function extend_or_override(config, custom, ...)
  if type(custom) == "function" then
    config = custom(config, ...) or config
  elseif custom then
    config = vim.tbl_deep_extend("force", config, custom) --[[@as table]]
  end
  return config
end
local printTable = require("utils.fn").printTable

local jdtls = require("jdtls")
local mason_registry = require("mason-registry")
local jdtls_install = mason_registry.get_package("jdtls"):get_install_path()
local lombok_jar = jdtls_install .. "/lombok.jar"
local launcher_jar = vim.fn.glob(jdtls_install .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local platform_config = jdtls_install .. "/config_linux"
local data_dir = vim.fn.stdpath("cache") .. "/nvim-jdtls/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local lsp_settings = {
  java = {
    -- jdt = {
    --   ls = {
    --     vmargs = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx1G -Xms100m"
    --   }
    -- },
    eclipse = {
      downloadSources = true,
    },
    configuration = {
      updateBuildConfiguration = "interactive",
      runtimes = {
        {
          name = "JavaSE-21",
          path = vim.fn.expand("~/.sdkman/candidates/java/21.0.4-tem"),
        },
      },
    },
    maven = {
      downloadSources = true,
    },
    implementationsCodeLens = {
      enabled = true,
    },
    referencesCodeLens = {
      enabled = true,
    },
    inlayHints = {
      parameterNames = {
        enabled = "all", -- literals, all, none
      },
    },
    format = {
      enabled = true,
      -- settings = {
      --   profile = 'asdf'
      -- },
    },
  },
  signatureHelp = {
    enabled = true,
  },
  completion = {
    favoriteStaticMembers = {
      "org.hamcrest.MatcherAssert.assertThat",
      "org.hamcrest.Matchers.*",
      "org.hamcrest.CoreMatchers.*",
      "org.junit.jupiter.api.Assertions.*",
      "java.util.Objects.requireNonNull",
      "java.util.Objects.requireNonNullElse",
      "org.mockito.Mockito.*",
    },
  },
  contentProvider = {
    preferred = "fernflower",
  },
  extendedClientCapabilities = jdtls.extendedClientCapabilities,
  sources = {
    organizeImports = {
      starThreshold = 9999,
      staticStarThreshold = 9999,
    },
  },
  codeGeneration = {
    toString = {
      template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
    },
    useBlocks = true,
  },
}

local opts = {
  -- How to find the root dir for a given filename. The default comes from
  -- lspconfig which provides a function specifically for java projects.
  root_dir = require("lspconfig.server_configurations.jdtls").default_config.root_dir,

  -- How to find the project name for a given root dir.
  project_name = function(root_dir)
    return root_dir and vim.fs.basename(root_dir)
  end,

  -- Where are the config and workspace dirs for a project?
  jdtls_config_dir = function(project_name)
    return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/config"
  end,
  jdtls_workspace_dir = function(project_name)
    return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/workspace"
  end,

  -- How to run jdtls. This can be overridden to a full java command-line
  -- if the Python wrapper script doesn't suffice.
  cmd = {
    -- 💀
    "java",

    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-javaagent:" .. lombok_jar,
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",

    -- 💀
    "-jar",
    launcher_jar,

    -- 💀
    "-configuration",
    platform_config,

    -- 💀
    "-data",
    data_dir,
  },

  -- These depend on nvim-dap, but can additionally be disabled by setting false here.
  dap = { hotcodereplace = "auto", config_overrides = {} },
  dap_main = {},
  test = true,
  settings = lsp_settings,
}

return {
  setup = function(on_attach, capabilities)
    -- Find the extra bundles that should be passed on the jdtls command-line
    -- if nvim-dap is enabled with java debug/test.
    local bundles = {} ---@type string[]
    local function init_bundles()
      local java_test_path = mason_registry.get_package("java-test"):get_install_path()

      local java_test_bundle = vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar", true), "\n")

      if java_test_bundle[1] ~= "" then
        vim.list_extend(bundles, java_test_bundle)
      end

      ---
      -- Include java-debug-adapter bundle if present
      ---
      local java_debug_path = require("mason-registry").get_package("java-debug-adapter"):get_install_path()

      local java_debug_bundle =
        vim.split(vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", true), "\n")

      if java_debug_bundle[1] ~= "" then
        vim.list_extend(bundles, java_debug_bundle)
      end
    end

    local function attach_jdtls()
      init_bundles()

      -- Configuration can be augmented and overridden by opts.jdtls
      local config = {
        cmd = opts.cmd,
        root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml" }),
        init_options = {
          bundles = bundles,
        },
        flags = {
          allow_incremental_sync = true,
        },
        settings = opts.settings,
        -- enable CMP capabilities
        capabilities = LazyVim.has("cmp-nvim-lsp") and capabilities or nil,
      }

      -- Existing server will be reused if the root_dir matches.
      require("jdtls").start_or_attach(config)
      -- not need to require("jdtls.setup").add_commands(), start automatically adds commands
    end

    -- Attach the jdtls for each java buffer. HOWEVER, this plugin loads
    -- depending on filetype, so this autocmd doesn't run for the first file.
    -- For that, we call directly below.
    vim.api.nvim_create_autocmd("FileType", {
      group = java_cmds,
      pattern = java_filetypes,
      callback = attach_jdtls,
    })

    -- Setup keymap and dap after the lsp is fully attached.
    -- https://github.com/mfussenegger/nvim-jdtls#nvim-dap-configuration
    -- https://neovim.io/doc/user/lsp.html#LspAttach
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == "jdtls" then
          local wk = require("which-key")
          wk.add({
            {
              mode = "n",
              buffer = args.buf,
              { "<leader>jx", group = "extract" },
              { "<leader>jxv", require("jdtls").extract_variable_all, desc = "Extract Variable" },
              { "<leader>jxc", require("jdtls").extract_constant, desc = "Extract Constant" },
              { "<leader>js", require("jdtls").super_implementation, desc = "Goto Super" },
              { "<leader>jS", require("jdtls.tests").goto_subjects, desc = "Goto Subjects" },
              { "<leader>jo", require("jdtls").organize_imports, desc = "Organize Imports" },
              { "<leader>jc", "<cmd>JdtCompile<cr>", desc = "Compile Current Project" },
            },
          })
          wk.add({
            {
              mode = "v",
              buffer = args.buf,
              { "<leader>jx", group = "extract" },
              {
                "<leader>jxm",
                [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
                desc = "Extract Method",
              },
              {
                "<leader>jxv",
                [[<ESC><CMD>lua require('jdtls').extract_variable_all(true)<CR>]],
                desc = "Extract Variable",
              },
              {
                "<leader>jxc",
                [[<ESC><CMD>lua require('jdtls').extract_constant(true)<CR>]],
                desc = "Extract Constant",
              },
            },
          })

          if opts.dap and LazyVim.has("nvim-dap") and mason_registry.is_installed("java-debug-adapter") then
            -- custom init for Java debugger
            require("jdtls").setup_dap(opts.dap)
            require("jdtls.dap").setup_dap_main_class_configs(opts.dap_main)

            -- Java Test require Java debugger to work
            if opts.test and mason_registry.is_installed("java-test") then
              -- custom keymaps for Java test runner (not yet compatible with neotest)
              wk.add({
                {
                  mode = "n",
                  buffer = args.buf,
                  { "<leader>jt", group = "test" },
                  {
                    "<leader>jtt",
                    function()
                      require("jdtls.dap").test_class({
                        config_overrides = type(opts.dap) ~= "boolean" and opts.dap.config_overrides or nil,
                      })
                    end,
                    desc = "Run All Test",
                  },
                  {
                    "<leader>jtr",
                    function()
                      require("jdtls.dap").test_nearest_method({
                        config_overrides = type(opts.dap) ~= "boolean" and opts.dap.config_overrides or nil,
                      })
                    end,
                    desc = "Run Nearest Test",
                  },
                  { "<leader>jtT", require("jdtls.dap").pick_test, desc = "Run Test" },
                },
              })
            end
          end

          -- User can set additional keymaps in opts.on_attach
          if opts.on_attach then
            opts.on_attach(args)
          end
        end
      end,
    })

    -- Avoid race condition by calling attach the first time, since the autocmd won't fire.
    attach_jdtls()
  end,
}
