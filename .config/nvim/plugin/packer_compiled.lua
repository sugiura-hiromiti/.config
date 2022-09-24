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
  LuaSnip = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["ayu-vim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/ayu-vim",
    url = "https://github.com/ayu-theme/ayu-vim"
  },
  ["bufdelete.nvim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/bufdelete.nvim",
    url = "https://github.com/famiu/bufdelete.nvim"
  },
  ["bufferline.nvim"] = {
    config = { "\27LJ\2\n<\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\15bufferline\frequire\0" },
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lsp-signature-help"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp-signature-help",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["comment-box.nvim"] = {
    config = { "\27LJ\2\nM\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\15line_width\3P\nsetup\16comment-box\frequire\0" },
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/comment-box.nvim",
    url = "https://github.com/LudoPinelli/comment-box.nvim"
  },
  ["lspkind.nvim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/lspkind.nvim",
    url = "https://github.com/onsails/lspkind.nvim"
  },
  ["lspsaga.nvim"] = {
    config = { "\27LJ\2\nÅ\1\0\0\4\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\2B\0\2\1K\0\1\0\17show_outline\1\0\1\14win_width\3$\26code_action_lightbulb\1\0\1\tsign\1\21symbol_in_winbar\1\0\0\1\0\2\18click_support\2\14in_custom\2\18init_lsp_saga\flspsaga\frequire\0" },
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/lspsaga.nvim",
    url = "https://github.com/glepnir/lspsaga.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    config = { "\27LJ\2\n{\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\21ensure_installed\1\0\0\1\3\0\0\16sumneko_lua\18rust_analyzer\nsetup\20mason-lspconfig\frequire\0" },
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason.nvim"] = {
    config = { "\27LJ\2\n›\1\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\aui\1\0\0\nicons\1\0\0\1\0\3\22package_installed\bâœ“\24package_uninstalled\bâœ—\20package_pending\bâžœ\nsetup\nmason\frequire\0" },
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["nova.nvim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/nova.nvim",
    url = "https://github.com/zanglg/nova.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\nÈ\1\0\0\a\0\n\0\0206\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\0\0'\2\4\0B\0\2\0026\1\0\0'\3\5\0B\1\2\0029\1\6\1\18\3\1\0009\1\a\1'\4\b\0009\5\t\0B\5\1\0A\1\2\1K\0\1\0\20on_confirm_done\17confirm_done\aon\nevent\bcmp\"nvim-autopairs.completion.cmp\1\0\1\fmap_c_h\2\nsetup\19nvim-autopairs\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/opt/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-dap"] = {
    config = { "\27LJ\2\no\0\0\5\0\6\0\0166\0\0\0009\0\1\0'\2\2\0B\0\2\2\14\0\0\0X\1\2€+\1\0\0L\1\2\0\18\3\0\0009\1\3\0'\4\4\0B\1\3\2\18\4\0\0009\2\5\0B\2\2\1L\1\2\0\nclose\6a\tread\22which lldb-vscode\npopen\aion\0\0\5\0\a\0\f6\0\0\0009\0\1\0009\0\2\0'\2\3\0006\3\0\0009\3\1\0039\3\4\3B\3\1\2'\4\5\0&\3\4\3'\4\6\0D\0\4\0\tfile\r/target/\vgetcwd\25Path to executable: \ninput\afn\bvimg\0\0\5\0\a\0\f6\0\0\0009\0\1\0009\0\2\0'\2\3\0006\3\0\0009\3\1\0039\3\4\3B\3\1\2'\4\5\0&\3\4\3'\4\6\0D\0\4\0\tfile\6/\vgetcwd\25Path to executable: \ninput\afn\bvimË\2\1\0\6\0\17\0#3\0\0\0006\1\1\0'\3\2\0B\1\2\0029\2\3\0015\3\5\0\18\4\0\0B\4\1\2=\4\6\3=\3\4\0029\2\a\0014\3\3\0005\4\t\0003\5\n\0=\5\v\0044\5\0\0=\5\f\4>\4\1\3=\3\b\0029\2\a\0019\3\a\0019\3\b\3=\3\r\0029\2\a\0014\3\3\0005\4\15\0003\5\14\0=\5\v\4>\4\1\3=\3\r\0029\2\a\0019\3\a\0019\3\r\3=\3\16\2K\0\1\0\bcpp\1\0\0\0\6c\targs\fprogram\0\1\0\5\tname\vLaunch\bcwd\23${workspaceFolder}\16stopOnEntry\1\frequest\vlaunch\ttype\tlldb\trust\19configurations\fcommand\1\0\2\tname\tlldb\ttype\15executable\tlldb\radapters\bdap\frequire\0\0" },
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-hlslens"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/nvim-hlslens",
    url = "https://github.com/kevinhwang91/nvim-hlslens"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-notify"] = {
    config = { "\27LJ\2\na\0\0\4\0\5\0\t6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0B\1\2\0016\1\4\0=\0\1\1K\0\1\0\bvim\1\0\1\22background_colour\f#000000\nsetup\vnotify\frequire\0" },
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-scrollbar"] = {
    config = { "\27LJ\2\ne\0\0\3\0\4\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\3\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\30scrollbar.handlers.search\nsetup\14scrollbar\frequire\0" },
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/nvim-scrollbar",
    url = "https://github.com/petertriho/nvim-scrollbar"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\nÁ\1\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\14highlight\1\0\2&additional_vim_regex_highlighting\1\venable\2\21ensure_installed\1\0\1\17sync_install\2\1\3\0\0\ttoml\thelp\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["project.nvim"] = {
    config = { "\27LJ\2\n¬\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\rpatterns\1\0\2\17silent_chdir\1\16show_hidden\2\1\t\0\0\t.git\v_darcs\b.hg\t.bzr\t.svn\rMakefile\17package.json\15Cargo.toml\nsetup\17project_nvim\frequire\0" },
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/project.nvim",
    url = "https://github.com/ahmedkhalf/project.nvim"
  },
  ["sqlite.lua"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/sqlite.lua",
    url = "https://github.com/kkharji/sqlite.lua"
  },
  sunset = {
    config = { "\27LJ\2\nf\0\0\2\0\4\2\t6\0\0\0009\0\1\0*\1\0\0=\1\2\0006\0\0\0009\0\1\0*\1\1\0=\1\3\0K\0\1\0\21sunset_longitude\20sunset_latitude\6g\bvimÉÂë£\1×‡†‚\4Ãë£á\21Çòƒƒ\4\0" },
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/sunset",
    url = "https://github.com/amdt/sunset"
  },
  ["telescope-file-browser.nvim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/telescope-file-browser.nvim",
    url = "https://github.com/nvim-telescope/telescope-file-browser.nvim"
  },
  ["telescope-frecency.nvim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/telescope-frecency.nvim",
    url = "https://github.com/nvim-telescope/telescope-frecency.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\nÉ\2\0\0\5\0\17\0)6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\0025\3\t\0005\4\b\0=\4\n\0035\4\v\0=\4\f\3=\3\r\2B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\14\0'\2\15\0B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\14\0'\2\n\0B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\14\0'\2\f\0B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\14\0'\2\16\0B\0\2\1K\0\1\0\rprojects\rfrecency\19load_extension\15extensions\bfzf\1\0\1\nfuzzy\2\17file_browser\1\0\0\1\0\2\vhidden\2\17hijack_netrw\2\fpickers\1\0\0\14findfiles\1\0\0\1\0\1\vhidden\2\nsetup\14telescope\frequire\0" },
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["toast.vim"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/toast.vim",
    url = "https://github.com/jsit/toast.vim"
  },
  ["vim-illuminate"] = {
    config = { "\27LJ\2\nS\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0004hi IlluminatedWordWrite gui=bold guibg=DarkGray\bcmd\bvim\0" },
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/vim-illuminate",
    url = "https://github.com/RRethy/vim-illuminate"
  },
  ["vim-wakatime"] = {
    loaded = true,
    path = "/Users/sugiurahiroshiiki/.local/share/nvim/site/pack/packer/start/vim-wakatime",
    url = "https://github.com/wakatime/vim-wakatime"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-notify
time([[Config for nvim-notify]], true)
try_loadstring("\27LJ\2\na\0\0\4\0\5\0\t6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0B\1\2\0016\1\4\0=\0\1\1K\0\1\0\bvim\1\0\1\22background_colour\f#000000\nsetup\vnotify\frequire\0", "config", "nvim-notify")
time([[Config for nvim-notify]], false)
-- Config for: sunset
time([[Config for sunset]], true)
try_loadstring("\27LJ\2\nf\0\0\2\0\4\2\t6\0\0\0009\0\1\0*\1\0\0=\1\2\0006\0\0\0009\0\1\0*\1\1\0=\1\3\0K\0\1\0\21sunset_longitude\20sunset_latitude\6g\bvimÉÂë£\1×‡†‚\4Ãë£á\21Çòƒƒ\4\0", "config", "sunset")
time([[Config for sunset]], false)
-- Config for: bufferline.nvim
time([[Config for bufferline.nvim]], true)
try_loadstring("\27LJ\2\n<\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\15bufferline\frequire\0", "config", "bufferline.nvim")
time([[Config for bufferline.nvim]], false)
-- Config for: nvim-scrollbar
time([[Config for nvim-scrollbar]], true)
try_loadstring("\27LJ\2\ne\0\0\3\0\4\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\3\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\30scrollbar.handlers.search\nsetup\14scrollbar\frequire\0", "config", "nvim-scrollbar")
time([[Config for nvim-scrollbar]], false)
-- Config for: vim-illuminate
time([[Config for vim-illuminate]], true)
try_loadstring("\27LJ\2\nS\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0004hi IlluminatedWordWrite gui=bold guibg=DarkGray\bcmd\bvim\0", "config", "vim-illuminate")
time([[Config for vim-illuminate]], false)
-- Config for: lspsaga.nvim
time([[Config for lspsaga.nvim]], true)
try_loadstring("\27LJ\2\nÅ\1\0\0\4\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\2B\0\2\1K\0\1\0\17show_outline\1\0\1\14win_width\3$\26code_action_lightbulb\1\0\1\tsign\1\21symbol_in_winbar\1\0\0\1\0\2\18click_support\2\14in_custom\2\18init_lsp_saga\flspsaga\frequire\0", "config", "lspsaga.nvim")
time([[Config for lspsaga.nvim]], false)
-- Config for: nvim-dap
time([[Config for nvim-dap]], true)
try_loadstring("\27LJ\2\no\0\0\5\0\6\0\0166\0\0\0009\0\1\0'\2\2\0B\0\2\2\14\0\0\0X\1\2€+\1\0\0L\1\2\0\18\3\0\0009\1\3\0'\4\4\0B\1\3\2\18\4\0\0009\2\5\0B\2\2\1L\1\2\0\nclose\6a\tread\22which lldb-vscode\npopen\aion\0\0\5\0\a\0\f6\0\0\0009\0\1\0009\0\2\0'\2\3\0006\3\0\0009\3\1\0039\3\4\3B\3\1\2'\4\5\0&\3\4\3'\4\6\0D\0\4\0\tfile\r/target/\vgetcwd\25Path to executable: \ninput\afn\bvimg\0\0\5\0\a\0\f6\0\0\0009\0\1\0009\0\2\0'\2\3\0006\3\0\0009\3\1\0039\3\4\3B\3\1\2'\4\5\0&\3\4\3'\4\6\0D\0\4\0\tfile\6/\vgetcwd\25Path to executable: \ninput\afn\bvimË\2\1\0\6\0\17\0#3\0\0\0006\1\1\0'\3\2\0B\1\2\0029\2\3\0015\3\5\0\18\4\0\0B\4\1\2=\4\6\3=\3\4\0029\2\a\0014\3\3\0005\4\t\0003\5\n\0=\5\v\0044\5\0\0=\5\f\4>\4\1\3=\3\b\0029\2\a\0019\3\a\0019\3\b\3=\3\r\0029\2\a\0014\3\3\0005\4\15\0003\5\14\0=\5\v\4>\4\1\3=\3\r\0029\2\a\0019\3\a\0019\3\r\3=\3\16\2K\0\1\0\bcpp\1\0\0\0\6c\targs\fprogram\0\1\0\5\tname\vLaunch\bcwd\23${workspaceFolder}\16stopOnEntry\1\frequest\vlaunch\ttype\tlldb\trust\19configurations\fcommand\1\0\2\tname\tlldb\ttype\15executable\tlldb\radapters\bdap\frequire\0\0", "config", "nvim-dap")
time([[Config for nvim-dap]], false)
-- Config for: comment-box.nvim
time([[Config for comment-box.nvim]], true)
try_loadstring("\27LJ\2\nM\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\15line_width\3P\nsetup\16comment-box\frequire\0", "config", "comment-box.nvim")
time([[Config for comment-box.nvim]], false)
-- Config for: mason-lspconfig.nvim
time([[Config for mason-lspconfig.nvim]], true)
try_loadstring("\27LJ\2\n{\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\21ensure_installed\1\0\0\1\3\0\0\16sumneko_lua\18rust_analyzer\nsetup\20mason-lspconfig\frequire\0", "config", "mason-lspconfig.nvim")
time([[Config for mason-lspconfig.nvim]], false)
-- Config for: project.nvim
time([[Config for project.nvim]], true)
try_loadstring("\27LJ\2\n¬\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\rpatterns\1\0\2\17silent_chdir\1\16show_hidden\2\1\t\0\0\t.git\v_darcs\b.hg\t.bzr\t.svn\rMakefile\17package.json\15Cargo.toml\nsetup\17project_nvim\frequire\0", "config", "project.nvim")
time([[Config for project.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\nÁ\1\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\14highlight\1\0\2&additional_vim_regex_highlighting\1\venable\2\21ensure_installed\1\0\1\17sync_install\2\1\3\0\0\ttoml\thelp\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: mason.nvim
time([[Config for mason.nvim]], true)
try_loadstring("\27LJ\2\n›\1\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\aui\1\0\0\nicons\1\0\0\1\0\3\22package_installed\bâœ“\24package_uninstalled\bâœ—\20package_pending\bâžœ\nsetup\nmason\frequire\0", "config", "mason.nvim")
time([[Config for mason.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\nÉ\2\0\0\5\0\17\0)6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\0025\3\t\0005\4\b\0=\4\n\0035\4\v\0=\4\f\3=\3\r\2B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\14\0'\2\15\0B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\14\0'\2\n\0B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\14\0'\2\f\0B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\14\0'\2\16\0B\0\2\1K\0\1\0\rprojects\rfrecency\19load_extension\15extensions\bfzf\1\0\1\nfuzzy\2\17file_browser\1\0\0\1\0\2\vhidden\2\17hijack_netrw\2\fpickers\1\0\0\14findfiles\1\0\0\1\0\1\vhidden\2\nsetup\14telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd nvim-cmp ]]
vim.cmd [[ packadd nvim-autopairs ]]

-- Config for: nvim-autopairs
try_loadstring("\27LJ\2\nÈ\1\0\0\a\0\n\0\0206\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\0\0'\2\4\0B\0\2\0026\1\0\0'\3\5\0B\1\2\0029\1\6\1\18\3\1\0009\1\a\1'\4\b\0009\5\t\0B\5\1\0A\1\2\1K\0\1\0\20on_confirm_done\17confirm_done\aon\nevent\bcmp\"nvim-autopairs.completion.cmp\1\0\1\fmap_c_h\2\nsetup\19nvim-autopairs\frequire\0", "config", "nvim-autopairs")

time([[Sequenced loading]], false)

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
