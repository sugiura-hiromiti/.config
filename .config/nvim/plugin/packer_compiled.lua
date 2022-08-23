-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

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

  _G._packer = _G._packer or {}
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
  NeoSolarized = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/NeoSolarized",
    url = "https://github.com/overcache/NeoSolarized"
  },
  ["aquarium-vim"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/aquarium-vim",
    url = "https://github.com/FrenzyExists/aquarium-vim"
  },
  catppuccin = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/catppuccin",
    url = "https://github.com/catppuccin/nvim"
  },
  ["citylights.vim"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/citylights.vim",
    url = "https://github.com/saltdotac/citylights.vim"
  },
  ["cobalt2-vim-theme"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/cobalt2-vim-theme",
    url = "https://github.com/GertjanReynaert/cobalt2-vim-theme"
  },
  ["coc.nvim"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/coc.nvim",
    url = "https://github.com/neoclide/coc.nvim"
  },
  edge = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/edge",
    url = "https://github.com/sainnhe/edge"
  },
  everforest = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/everforest",
    url = "https://github.com/sainnhe/everforest"
  },
  ["flatui.vim"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/flatui.vim",
    url = "https://github.com/ah-y/flatui.vim"
  },
  ["iceberg.vim"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/iceberg.vim",
    url = "https://github.com/cocopon/iceberg.vim"
  },
  ["lexima.vim"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/lexima.vim",
    url = "https://github.com/cohama/lexima.vim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["night-owl.vim"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/night-owl.vim",
    url = "https://github.com/haishanh/night-owl.vim"
  },
  ["nord-vim"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/nord-vim",
    url = "https://github.com/arcticicestudio/nord-vim"
  },
  ["nova.nvim"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/nova.nvim",
    url = "https://github.com/zanglg/nova.nvim"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["oceanic-next-vim"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/oceanic-next-vim",
    url = "https://github.com/adrian5/oceanic-next-vim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["palenight.vim"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/palenight.vim",
    url = "https://github.com/drewtempelmeyer/palenight.vim"
  },
  ["papercolor-theme"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/papercolor-theme",
    url = "https://github.com/NLKNguyen/papercolor-theme"
  },
  sunset = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/sunset",
    url = "https://github.com/amdt/sunset"
  },
  ["toast.vim"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/toast.vim",
    url = "https://github.com/jsit/toast.vim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["vim-aurora"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/vim-aurora",
    url = "https://github.com/rafalbromirski/vim-aurora"
  },
  ["vim-colors-github"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/vim-colors-github",
    url = "https://github.com/cormacrelf/vim-colors-github"
  },
  ["vim-colors-xcode"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/vim-colors-xcode",
    url = "https://github.com/arzg/vim-colors-xcode"
  },
  ["vim-colorscheme-primary"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/vim-colorscheme-primary",
    url = "https://github.com/google/vim-colorscheme-primary"
  },
  ["vim-humanoid-colorscheme"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/vim-humanoid-colorscheme",
    url = "https://github.com/humanoid-colors/vim-humanoid-colorscheme"
  },
  ["vim-hybrid"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/vim-hybrid",
    url = "https://github.com/w0ng/vim-hybrid"
  },
  ["vim-kalisi"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/vim-kalisi",
    url = "https://github.com/freeo/vim-kalisi"
  },
  ["vim-lucius"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/vim-lucius",
    url = "https://github.com/jonathanfilip/vim-lucius"
  },
  ["vim-tomorrow-theme"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/vim-tomorrow-theme",
    url = "https://github.com/chriskempson/vim-tomorrow-theme"
  },
  ["vim-transparent"] = {
    loaded = true,
    path = "/Users/r/.local/share/nvim/site/pack/packer/start/vim-transparent",
    url = "https://github.com/ah-y/vim-transparent"
  }
}

time([[Defining packer_plugins]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
