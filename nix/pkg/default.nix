{
  user,
  os,
  arch,
  system,
  pkgs,
  fenix,
}:
(
  with pkgs;
  [
    fenix.packages.${system}.latest.toolchain
    git
    curl
    dprint
    eza
    fd
    gh
    # lazygit
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
    tailscale
    bat
    tokei
    cargo-expand
    yaml-language-server
    sd
    direnv
    codex
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
    aerospace
    tart
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
        # sketchybar
        # sbarlua
      ]
    else
      [ ]
  )
  ++ (
    if os == "linux" then
      [
        nyxt
        obsidian
        anki
        unixtools.xxd
        docker
        swift
        regreet
        ironbar
        sherlock
        # not rusty
        mako
        # not rusty, but ziggy
        waylock
        swww
        # clipcat
      ]
    else
      [ ]
  )
  ++ (if arch == "aarch64" && os == "darwin" then [ ] else [ ])
  ++ (if arch == "x86_64" && os == "darwin" then [ ] else [ ])
  ++ (if arch == "aarch64" && os == "linux" then [ slacky ] else [ ])
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
