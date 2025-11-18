{
  user,
  os,
  arch,
  system,
  pkgs,
  fenix,
  awww,
}:
(
  with pkgs;
  [
    fenix.packages.${system}.latest.toolchain
    awww.packages.${pkgs.system}.awww
    git
    curl
    dprint
    eza
    fd
    gh
    gitui
    lua5_4_compat
    lua-language-server
    luajitPackages.luarocks
    markdown-oxide
    neovim
    ripgrep
    rm-improved
    skim
    starship
    stylua
    taplo
    zoxide
    plemoljp-nf
    fish
    # well-fish-pkgs.legacyPackages.${system}.fish
    tailscale
    bat
    tokei
    cargo-expand
    yaml-language-server
    sd
    direnv
    nil
    viu
    fish-lsp
    fzf
    uv
    mcp-proxy
    vscode-langservers-extracted
    babelfish
    gemini-cli
    libmysqlclient
    google-cloud-sdk
    nodejs
    cargo-watch
    terraform
    terraform-ls
    wezterm
    typescript-language-server
    bun
    firefox
    sqlite
  ]
  ++ (if arch == "aarch64" then [ ] else [ ])
  ++ (if arch == "x86_64" then [ ] else [ ])
  ++ (
    if os == "darwin" then
      [
        # chatgpt
        mas
        pngpaste
        jankyborders
        aerospace
        # tart
        # sketchybar
        # sbarlua
      ]
    else
      [ ]
  )
  ++ (
    if os == "linux" then
      [
        # open-vm-tools
        zig # required by treesitter neovim plugin to build schema
        wl-clipboard-rs
        obsidian
        # anki
        unixtools.xxd
        # regreet
        # ironbar
        # sherlock
        anyrun
        # not rusty
        mako
        # not rusty, but ziggy
        # waylock
        # swww
        # clipcat
      ]
    else
      [ ]
  )
  ++ (if arch == "aarch64" && os == "darwin" then [ ] else [ ])
  ++ (if arch == "x86_64" && os == "darwin" then [ ] else [ ])
  ++ (if arch == "aarch64" && os == "linux" then [ ] else [ ])
  ++ (
    if arch == "x86_64" && os == "linux" then
      [
        discord
        slack
        vital
      ]
    else
      [ ]
  )
  ++ (if user == "a" then [ ] else [ ])
  ++ (if user == "hiromichi-sugiura" then [ ] else [ ])
  ++ (if user == "xsugiurah" then [ ] else [ ])
)
