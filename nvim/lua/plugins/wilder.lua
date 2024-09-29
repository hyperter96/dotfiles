return {
  "gelguy/wilder.nvim",
  optional = true,
  event = "CmdlineEnter",
  dependencies = "romgrk/fzy-lua-native",
  build = ":UpdateRemotePlugins",
  config = function()
    local wilder = require("wilder")
    wilder.setup({ modes = { ":", "/", "?" } })
    local colors = require("colorscheme")

    -- Disable Python remote plugin
    wilder.set_option("use_python_remote_plugin", 0)

    wilder.set_option("pipeline", {
      wilder.branch(
        wilder.cmdline_pipeline({
          fuzzy = 1,
          fuzzy_filter = wilder.lua_fzy_filter(),
        }),
        wilder.vim_search_pipeline()
      ),
    })

    wilder.set_option(
      "renderer",
      wilder.renderer_mux({
        [":"] = wilder.popupmenu_renderer(wilder.popupmenu_palette_theme({
          -- 'single', 'double', 'rounded' or 'solid'
          -- can also be a list of 8 characters, see :h wilder#popupmenu_palette_theme() for more details
          border = "rounded",
          max_height = "85%", -- max height of the palette
          min_height = 0, -- set to the same as 'max_height' for a fixed height window
          prompt_position = "top", -- 'top' or 'bottom' to set the location of the prompt
          reverse = 0, -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
        })),
        ["/"] = wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
          highlighter = wilder.lua_fzy_highlighter(),
          highlights = {
            accent = wilder.make_hl(
              "WilderAccent",
              "Pmenu",
              { { a = 1 }, { a = 1 }, { foreground = colors.peachRed } }
            ),
          },
          right = {
            " ",
            wilder.popupmenu_scrollbar(),
          },
        })),
      })
    )

    wilder.setup({
      modes = { ":", "/", "?" },
      next_key = "<C-n>",
      previous_key = "<C-p>",
    })
  end,
}
