return {
  'goolord/alpha-nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local alpha = require('alpha')
    local dashboard = require('alpha.themes.dashboard')

    vim.g.mapleader = " "
    vim.g.maplocalleader = " "

    dashboard.section.header.val = {
      "█▀▀▀▀▀▀▀▀▀▀▀▀▀█",
      "▀   ░░░░░░░   ▀",
      "   ░▒▒▒▒▒▒▒░",
      "   ▒▓▓▓▓▓▓▓▒",
      "   ░▒▓███▓▒░",
      "   ▒▓▓▓▓▓▓▓▒",
      "   ░▒▒▒▒▒▒▒░",
      "▄   ░░░░░░░   ▄",
      "█▄▄▄▄▄▄▄▄▄▄▄▄▄█",
    }
    dashboard.section.header.opts.hl = "Type"

    local subheader = {
      type = "text",
      val = "Apogee Neovim",
      opts = {
        position = "center",
        hl = "String",
      },
    }

local function spc_button(keys, icon, desc, action)
      local spaced = keys:gsub("(.)", "%1 "):gsub("%s+$", "") -- "ff" -> "f f"
      local btn = dashboard.button("<leader>" .. keys, icon .. "  " .. desc, action)

      btn.opts.shortcut = "SPC " .. spaced
      btn.opts.hl = "Keyword"
      btn.opts.hl_shortcut = "Number"
      return btn
    end

    dashboard.section.buttons.val = {
      spc_button("ff", "", "Find file",    ":Telescope find_files <CR>"),
      spc_button("fr", "", "Recent files", ":Telescope oldfiles <CR>"),
      spc_button("fg", "", "Find text",    ":Telescope live_grep <CR>"),
      spc_button("fn", "", "New file",     ":ene <BAR> startinsert <CR>"),
      spc_button("fc", "", "Config",       ":e $MYVIMRC <CR>"),
      spc_button("qq", "", "Quit",         ":qa <CR>"),
    }

    dashboard.section.footer.val = "Tat tvam asi"
    dashboard.section.footer.opts.hl = "Comment"

    dashboard.config.layout = {
      { type = "padding", val = 2 },
      dashboard.section.header,
      { type = "padding", val = 1 },
      subheader,
      { type = "padding", val = 2 },
      dashboard.section.buttons,
      { type = "padding", val = 1 },
      dashboard.section.footer,
    }

    alpha.setup(dashboard.opts)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "alpha",
      callback = function()
        vim.opt_local.foldenable = false
      end,
    })
  end,
}
