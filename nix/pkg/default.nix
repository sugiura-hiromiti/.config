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
    gitui
    lua5_4_compat
    lua-language-server
    luajitPackages.luarocks
    marksman
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
    # sbarlua build dependencies
    # clang
    # libllvm
    sd
    direnv
    codex
    nil
    viu
    fish-lsp
    fzf
    brave
    # amazon-q-cli
    uv
    reaper
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
        obsidian
        anki
        unixtools.xxd
        docker
        ghostty
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
