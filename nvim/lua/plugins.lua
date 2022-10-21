local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
    vim.cmd("packadd packer.nvim")
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  use {
    {
      "williamboman/mason.nvim",
      config = [[require("mason").setup()]]
    },
    {
      "williamboman/mason-lspconfig.nvim",
      config = [[require("mason-lspconfig").setup()]]
    },
    {
      "neovim/nvim-lspconfig",
      config = [[require("config.lspconfig")]]
    },
  }

  use "github/copilot.vim"

  use {
    "ms-jpq/coq_nvim",
    requires = {
      { "ms-jpq/coq.thirdparty", branch = "3p" },
      { "ms-jpq/coq.artifacts", branch = "artifacts" },
    },
    config = [[
      vim.g.coq_settings = { auto_start = "shut-up" }
      require("coq_3p") {
        { src = "copilot", short_name = "COP", accept_key = "<c-f>" }
      }
    ]]
  }

  use {
    "nvim-tree/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons",
    },
    config = [[
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("nvim-tree").setup {
        open_on_setup = true,
        open_on_setup_file = true,
        filters = { custom = { "^.git$" } },
      }
    ]]
  }

  use {
    "nvim-telescope/telescope.nvim", tag = "0.1.0",
    requires = {
      {"nvim-lua/plenary.nvim"}
    },
    config = [[
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "ff", builtin.find_files, {})
      vim.keymap.set("n", "fg", builtin.live_grep, {})
      vim.keymap.set("n", "fb", builtin.buffers, {})
      vim.keymap.set("n", "fh", builtin.help_tags, {})
    ]]
  }

  use {
    "tpope/vim-fugitive",
    "gpanders/editorconfig.nvim",
    "tssm/fairyfloss.vim",
  }

  if packer_bootstrap then
    require("packer").sync()
  end
end)
