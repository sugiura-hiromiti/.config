-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/sugiurahiroshiiki/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/sugiurahiroshiiki/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/sugiurahiroshiiki/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/sugiurahiroshiiki/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/sugiurahiroshiiki/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  Lightning = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/Lightning",
    url = "https://github.com/wimstefan/Lightning"
  },
  LuaSnip = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  NeoSolarized = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/NeoSolarized",
    url = "https://github.com/overcache/NeoSolarized"
  },
  ["am-colors"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/am-colors",
    url = "https://github.com/muellan/am-colors"
  },
  ["aquarium-vim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/aquarium-vim",
    url = "https://github.com/FrenzyExists/aquarium-vim"
  },
  ["atlas.vim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/atlas.vim",
    url = "https://github.com/ajlende/atlas.vim"
  },
  ["bat.vim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/bat.vim",
    url = "https://github.com/jamespwilliams/bat.vim"
  },
  carbonized = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/carbonized",
    url = "https://github.com/vinodshelke82/carbonized"
  },
  catppuccin = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/catppuccin",
    url = "https://github.com/catppuccin/nvim"
  },
  ["citylights.vim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/citylights.vim",
    url = "https://github.com/saltdotac/citylights.vim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["cobalt2-vim-theme"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/cobalt2-vim-theme",
    url = "https://github.com/GertjanReynaert/cobalt2-vim-theme"
  },
  ["colibri.vim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/colibri.vim",
    url = "https://github.com/archseer/colibri.vim"
  },
  edge = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/edge",
    url = "https://github.com/sainnhe/edge"
  },
  ["envylabs.vim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/envylabs.vim",
    url = "https://github.com/willian/envylabs.vim"
  },
  everforest = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/everforest",
    url = "https://github.com/sainnhe/everforest"
  },
  ["flatui.vim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/flatui.vim",
    url = "https://github.com/ah-y/flatui.vim"
  },
  ["gitgud.nvim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/gitgud.nvim",
    url = "https://github.com/elianiva/gitgud.nvim"
  },
  ["guepardo.vim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/guepardo.vim",
    url = "https://github.com/vim-scripts/guepardo.vim"
  },
  ["iceberg.vim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/iceberg.vim",
    url = "https://github.com/cocopon/iceberg.vim"
  },
  ["inkstained-vim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/inkstained-vim",
    url = "https://github.com/yuttie/inkstained-vim"
  },
  ["kalahari.vim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/kalahari.vim",
    url = "https://github.com/fabi1cazenave/kalahari.vim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason.nvim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["material.vim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/material.vim",
    url = "https://github.com/kaicataldo/material.vim"
  },
  materialbox = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/materialbox",
    url = "https://github.com/mkarmona/materialbox"
  },
  ["night-owl.vim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/night-owl.vim",
    url = "https://github.com/haishanh/night-owl.vim"
  },
  ["nord-vim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/nord-vim",
    url = "https://github.com/arcticicestudio/nord-vim"
  },
  ["nova.nvim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/nova.nvim",
    url = "https://github.com/zanglg/nova.nvim"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["oceanic-next"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/oceanic-next",
    url = "https://github.com/mhartington/oceanic-next"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["palenight.vim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/palenight.vim",
    url = "https://github.com/drewtempelmeyer/palenight.vim"
  },
  ["papercolor-theme"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/papercolor-theme",
    url = "https://github.com/NLKNguyen/papercolor-theme"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["quietlight.vim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/quietlight.vim",
    url = "https://github.com/aonemd/quietlight.vim"
  },
  ["soda.vim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/soda.vim",
    url = "https://github.com/DAddYE/soda.vim"
  },
  ["sqlite.lua"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/sqlite.lua",
    url = "https://github.com/kkharji/sqlite.lua"
  },
  ["subatomic256.vim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/subatomic256.vim",
    url = "https://github.com/d11wtq/subatomic256.vim"
  },
  ["summerfruit256.vim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/summerfruit256.vim",
    url = "https://github.com/ku-s-h/summerfruit256.vim"
  },
  sunset = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/sunset",
    url = "https://github.com/amdt/sunset"
  },
  ["telescope-frecency.nvim"] = {
    config = { "\27LJ\2\nM\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\rfrecency\19load_extension\14telescope\frequire\0" },
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/telescope-frecency.nvim",
    url = "https://github.com/nvim-telescope/telescope-frecency.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["toast.vim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/toast.vim",
    url = "https://github.com/jsit/toast.vim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["vim-aurora"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/vim-aurora",
    url = "https://github.com/rafalbromirski/vim-aurora"
  },
  ["vim-colors-bluedrake"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/vim-colors-bluedrake",
    url = "https://github.com/michaelmalick/vim-colors-bluedrake"
  },
  ["vim-colors-github"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/vim-colors-github",
    url = "https://github.com/cormacrelf/vim-colors-github"
  },
  ["vim-colors-xcode"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/vim-colors-xcode",
    url = "https://github.com/arzg/vim-colors-xcode"
  },
  ["vim-colorscheme-primary"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/vim-colorscheme-primary",
    url = "https://github.com/google/vim-colorscheme-primary"
  },
  ["vim-framer-syntax"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/vim-framer-syntax",
    url = "https://github.com/balanceiskey/vim-framer-syntax"
  },
  ["vim-fruchtig"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/vim-fruchtig",
    url = "https://github.com/schickele/vim-fruchtig"
  },
  ["vim-habaurora"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/vim-habaurora",
    url = "https://github.com/habamax/vim-habaurora"
  },
  ["vim-humanoid-colorscheme"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/vim-humanoid-colorscheme",
    url = "https://github.com/humanoid-colors/vim-humanoid-colorscheme"
  },
  ["vim-kalisi"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/vim-kalisi",
    url = "https://github.com/freeo/vim-kalisi"
  },
  ["vim-open-color"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/vim-open-color",
    url = "https://github.com/yous/vim-open-color"
  },
  ["vim-pinata"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/vim-pinata",
    url = "https://github.com/AndrewVos/vim-pinata"
  },
  ["vim-prism"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/vim-prism",
    url = "https://github.com/vimpostor/vim-prism"
  },
  ["vim-theme-bronkow"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/vim-theme-bronkow",
    url = "https://github.com/cange/vim-theme-bronkow"
  },
  ["vim-tomorrow-theme"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/vim-tomorrow-theme",
    url = "https://github.com/chriskempson/vim-tomorrow-theme"
  },
  ["vim-transparent"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/vim-transparent",
    url = "https://github.com/ah-y/vim-transparent"
  },
  ["vim-wwdc17-theme"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/vim-wwdc17-theme",
    url = "https://github.com/lifepillar/vim-wwdc17-theme"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: telescope-frecency.nvim
time([[Config for telescope-frecency.nvim]], true)
try_loadstring("\27LJ\2\nM\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\rfrecency\19load_extension\14telescope\frequire\0", "config", "telescope-frecency.nvim")
time([[Config for telescope-frecency.nvim]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
