return {
  {
    "David-Kunz/gen.nvim",
    -- opts = {
    --     model = "llama3.1:latest", -- The default model to use.
    --     quit_map = "q", -- set keymap for close the response window
    --     retry_map = "<c-r>", -- set keymap to re-send the current prompt
    --     accept_map = "<c-cr>", -- set keymap to replace the previous selection with the last result
    --     host = "localhost", -- The host running the Ollama service.
    --     port = "11434", -- The port on which the Ollama service is listening.
    --     display_mode = "float", -- The display mode. Can be "float" or "split" or "horizontal-split".
    --     show_prompt = false, -- Shows the prompt submitted to Ollama.
    --     show_model = true, -- Displays which model you are using at the beginning of your chat session.
    --     no_auto_close = false, -- Never closes the window automatically.
    --     hidden = false, -- Hide the generation window (if true, will implicitly set `prompt.replace = true`), requires Neovim >= 0.10
    --     init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
    --     -- Function to initialize Ollama
    --     command = function(options)
    --         local context = require('gen.init').context
    --
    --         local body = vim.tbl_extend("force",
    --         {model = options.model, stream = true},
    --         options.body)
    --         local messages = {}
    --         if context then messages = context end
    --         -- Add new prompt to the context
    --         table.insert(messages, {role = "user", content = options.prompt})
    --         body.messages = messages
    --         if options.model_options ~= nil then -- override model options from gen command (if exist)
    --             body = vim.tbl_extend("force", body, options.model_options)
    --         end
    --
    --         local json = options.json(body)
    --         json = json:match("^'(.*)'$") or json  -- remove surrounding quotes
    --
    --         -- Write json to tmp file
    --         local fh, err = io.open("/tmp/tempfile", "w")
    --         if not fh then
    --             return nil, err
    --         end
    --         fh:write(json)
    --         fh:close()
    --         -- local body = {model = options.model, stream = true}
    --         return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d @/tmp/tempfile"
    --     end,
    --     -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
    --     -- This can also be a command string.
    --     -- The executed command must return a JSON object with { response, context }
    --     -- (context property is optional).
    --     -- list_models = '<omitted lua function>', -- Retrieves a list of model names
    --     debug = true -- Prints errors and the command which is run.
    -- },
    config = function ()
      require('gen').setup({
        model = "llama3.1",
        show_model = true,
        debug = true,
      })
      vim.keymap.set({'n', 'v'}, '<localleader>gs', ':Gen Enhance_Grammar_Spelling<CR>', {desc = "Enhance Grammer Spelling"})
      require("gen").prompts["Elaborate_Text"] = {
				prompt = "Elaborate the following text:\n$text",
				replace = true,
			}
			require("gen").prompts["Fix_Code"] = {
				prompt = "Fix the following code. Only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
				replace = true,
				extract = "```$filetype\n(.-)```",
			}
    end
  },
}
