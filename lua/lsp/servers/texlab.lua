local util = require("lspconfig.util")
local function rDir(fname)
  return util.root_pattern(util.find_git_ancestor(fname))
end

return {
  setup = function(_, __)
    require("lspconfig").texlab.setup({
      cmd = {
        "texlab",
      },
      filetypes = { "tex", "plaintex", "bib" },
      root_dir = rDir(fname),
      single_file_support = true,
      flags = {
        allow_incremental_sync = false,
      },
      settings = {
        texlab = {
          rootDirectory = rDir(fname),
          build = {
            args = {
              "-src",
              "-silent",
              "-output-directory=build",
              "-interaction=nonstopmode",
              "-synctex=1",
              "%f",
            },
            executable = "latexmk",
            forwardSearchAfter = true,
            onSave = false,
          },
          auxDirectory = "build",
          --[[ forwardSearch = { ]]
          --[[ 	executable = "pdflatex", ]]
          --[[ 	args = { ]]
          --[[ 		" -synctex=1", ]]
          --[[ 		"-interaction=nonstopmode", ]]
          --[[ 		"-output-directory=.build", ]]
          --[[ 		"%f", ]]
          --[[ 	} ]]
          --[[ }, ]]
          forwardSearch = {
            args = { "--synctex-forward", "%l:1:%f", "%p" },
            executable = "zathura",
          },
          chktex = {
            onOpenAndSave = true,
            onEdit = false,
          },
          diagnosticsDelay = 300,
          diagnostic = {
            allowedPatterns = {},
            ignoredPatterns = {},
          },
          formatterLineLength = 125,
          bibtexFormatter = "texlab",
          latexFormatter = "latexindent",
          latexindent = {
            modifyLineBreaks = true,
          },
        },
      },
    })
  end,
}
