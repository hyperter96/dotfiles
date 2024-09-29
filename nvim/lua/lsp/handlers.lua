local km, l, api = vim.keymap.set, vim.lsp, vim.api
local h, p = l.handlers, l.protocol

-- Change Error Signs in Gutter
local signs = { Error = "✘", Warn = " ", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Change border of documentation hover window, See https://github.com/neovim/neovim/pull/13998.
l.handlers["textDocument/hover"] = function(_, result, ctx, config)
  if not (result and result.contents) then
    return
  end
  config = config or {}
  config.border = "rounded"
  h.hover(_, result, ctx, config)
end
h["textDocument/signatureHelp"] = l.with(h.signature_help, {
  border = "rounded",
})
h["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
  local ts_lsp = { "tsserver", "angularls", "volar" }
  local clients = l.get_clients({ id = ctx.client_id })
  if vim.tbl_contains(ts_lsp, clients[1].name) then
    local filtered_result = {
      diagnostics = vim.tbl_filter(function(d)
        return d.severity == 1
      end, result.diagnostics),
    }
    require("ts-error-translator").translate_diagnostics(err, filtered_result, ctx, config)
  end
  l.diagnostic.on_publish_diagnostics(err, result, ctx, config)
end
local inlay_hint_handler = h[p.Methods["textDocument_inlayHint"]]
h[p.Methods["textDocument_inlayHint"]] = function(err, result, ctx, config)
  local client = l.get_client_by_id(ctx.client_id)
  if not result then
    result = {}
  end
  if client then
    local row = unpack(vim.api.nvim_win_get_cursor(0))
    result = vim
      .iter(result)
      :filter(function(hint)
        -- return math.abs(hint.position.line - row) <= 5
        return hint.position.line + 1 == row and vim.api.nvim_get_mode().mode == "i"
      end)
      :totable()
  end
  inlay_hint_handler(err, result, ctx, config)
end
