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
local package_path_str = "/Users/r/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/r/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/r/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/r/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/r/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
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
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lsp-signature-help"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp-signature-help",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["iceberg.vim"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/iceberg.vim",
    url = "https://github.com/cocopon/iceberg.vim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/lspsaga.nvim",
    url = "https://github.com/glepnir/lspsaga.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason.nvim"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\nÈ\1\0\0\a\0\n\0\0206\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\0\0'\2\4\0B\0\2\0029\0\5\0\18\2\0\0009\0\6\0'\3\a\0006\4\0\0'\6\b\0B\4\2\0029\4\t\4B\4\1\0A\0\2\1K\0\1\0\20on_confirm_done\"nvim-autopairs.completion.cmp\17confirm_done\aon\nevent\bcmp\1\0\1\fmap_c_h\2\nsetup\19nvim-autopairs\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/r/.local/share/nvim/site/pack/packer/opt/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-dap"] = {
    config = { "\27LJ\2\no\0\0\5\0\6\0\0166\0\0\0009\0\1\0'\2\2\0B\0\2\2\14\0\0\0X\1\2€+\1\0\0L\1\2\0\18\3\0\0009\1\3\0'\4\4\0B\1\3\2\18\4\0\0009\2\5\0B\2\2\1L\1\2\0\nclose\6a\tread\22which lldb-vscode\npopen\aiog\0\0\5\0\a\0\f6\0\0\0009\0\1\0009\0\2\0'\2\3\0006\3\0\0009\3\1\0039\3\4\3B\3\1\2'\4\5\0&\3\4\3'\4\6\0D\0\4\0\tfile\6/\vgetcwd\25Path to executable: \ninput\afn\bvim«\2\1\0\6\0\15\0\0283\0\0\0006\1\1\0'\3\2\0B\1\2\0029\2\3\0015\3\5\0\18\4\0\0B\4\1\2=\4\6\3=\3\4\0029\2\a\0014\3\3\0005\4\t\0003\5\n\0=\5\v\0044\5\0\0=\5\f\4>\4\1\3=\3\b\0029\2\a\0019\3\a\0019\3\b\3=\3\r\0029\2\a\0019\3\a\0019\3\b\3=\3\14\2K\0\1\0\bcpp\6c\targs\fprogram\0\1\0\5\bcwd\23${workspaceFolder}\frequest\vlaunch\tname\vLaunch\16stopOnEntry\1\ttype\tlldb\trust\19configurations\fcommand\1\0\2\tname\tlldb\ttype\15executable\tlldb\radapters\bdap\frequire\0\0" },
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["sqlite.lua"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/sqlite.lua",
    url = "https://github.com/kkharji/sqlite.lua"
  },
  sunset = {
    config = { "\27LJ\2\nf\0\0\2\0\4\2\t6\0\0\0009\0\1\0*\1\0\0=\1\2\0006\0\0\0009\0\1\0*\1\1\0=\1\3\0K\0\1\0\21sunset_longitude\20sunset_latitude\6g\bvimÉÂë£\1×‡†‚\4Ãë£á\21Çòƒƒ\4\0" },
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/sunset",
    url = "https://github.com/amdt/sunset"
  },
  ["telescope-file-browser.nvim"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/telescope-file-browser.nvim",
    url = "https://github.com/nvim-telescope/telescope-file-browser.nvim"
  },
  ["telescope-frecency.nvim"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/telescope-frecency.nvim",
    url = "https://github.com/nvim-telescope/telescope-frecency.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n«\2\0\0\5\0\16\0#6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\0025\3\t\0005\4\b\0=\4\n\0035\4\v\0=\4\f\3=\3\r\2B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\14\0'\2\15\0B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\14\0'\2\n\0B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\14\0'\2\f\0B\0\2\1K\0\1\0\rfrecency\19load_extension\15extensions\bfzf\1\0\1\nfuzzy\2\17file_browser\1\0\0\1\0\2\vhidden\2\20hide_parent_dir\2\fpickers\1\0\0\14findfiles\1\0\0\1\0\1\vhidden\2\nsetup\14telescope\frequire\0" },
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: sunset
time([[Config for sunset]], true)
try_loadstring("\27LJ\2\nf\0\0\2\0\4\2\t6\0\0\0009\0\1\0*\1\0\0=\1\2\0006\0\0\0009\0\1\0*\1\1\0=\1\3\0K\0\1\0\21sunset_longitude\20sunset_latitude\6g\bvimÉÂë£\1×‡†‚\4Ãë£á\21Çòƒƒ\4\0", "config", "sunset")
time([[Config for sunset]], false)
-- Config for: nvim-dap
time([[Config for nvim-dap]], true)
try_loadstring("\27LJ\2\no\0\0\5\0\6\0\0166\0\0\0009\0\1\0'\2\2\0B\0\2\2\14\0\0\0X\1\2€+\1\0\0L\1\2\0\18\3\0\0009\1\3\0'\4\4\0B\1\3\2\18\4\0\0009\2\5\0B\2\2\1L\1\2\0\nclose\6a\tread\22which lldb-vscode\npopen\aiog\0\0\5\0\a\0\f6\0\0\0009\0\1\0009\0\2\0'\2\3\0006\3\0\0009\3\1\0039\3\4\3B\3\1\2'\4\5\0&\3\4\3'\4\6\0D\0\4\0\tfile\6/\vgetcwd\25Path to executable: \ninput\afn\bvim«\2\1\0\6\0\15\0\0283\0\0\0006\1\1\0'\3\2\0B\1\2\0029\2\3\0015\3\5\0\18\4\0\0B\4\1\2=\4\6\3=\3\4\0029\2\a\0014\3\3\0005\4\t\0003\5\n\0=\5\v\0044\5\0\0=\5\f\4>\4\1\3=\3\b\0029\2\a\0019\3\a\0019\3\b\3=\3\r\0029\2\a\0019\3\a\0019\3\b\3=\3\14\2K\0\1\0\bcpp\6c\targs\fprogram\0\1\0\5\bcwd\23${workspaceFolder}\frequest\vlaunch\tname\vLaunch\16stopOnEntry\1\ttype\tlldb\trust\19configurations\fcommand\1\0\2\tname\tlldb\ttype\15executable\tlldb\radapters\bdap\frequire\0\0", "config", "nvim-dap")
time([[Config for nvim-dap]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n«\2\0\0\5\0\16\0#6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\0025\3\t\0005\4\b\0=\4\n\0035\4\v\0=\4\f\3=\3\r\2B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\14\0'\2\15\0B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\14\0'\2\n\0B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\14\0'\2\f\0B\0\2\1K\0\1\0\rfrecency\19load_extension\15extensions\bfzf\1\0\1\nfuzzy\2\17file_browser\1\0\0\1\0\2\vhidden\2\20hide_parent_dir\2\fpickers\1\0\0\14findfiles\1\0\0\1\0\1\vhidden\2\nsetup\14telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd nvim-cmp ]]
vim.cmd [[ packadd nvim-autopairs ]]

-- Config for: nvim-autopairs
try_loadstring("\27LJ\2\nÈ\1\0\0\a\0\n\0\0206\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\0\0'\2\4\0B\0\2\0029\0\5\0\18\2\0\0009\0\6\0'\3\a\0006\4\0\0'\6\b\0B\4\2\0029\4\t\4B\4\1\0A\0\2\1K\0\1\0\20on_confirm_done\"nvim-autopairs.completion.cmp\17confirm_done\aon\nevent\bcmp\1\0\1\fmap_c_h\2\nsetup\19nvim-autopairs\frequire\0", "config", "nvim-autopairs")

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
