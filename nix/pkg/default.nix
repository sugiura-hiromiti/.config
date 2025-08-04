{
  user,
  os,
  arch,
  pkgs,
}: (
  with pkgs;
    [
      git
      curl
      chibi
      deno
      dosfstools
      dprint
      eza
      fd
      gh
      gitui
      go
      #jdk
      jdk11
      google-java-format
      gopls
      graphviz
      jdt-language-server
      lua5_4_compat
      lua-language-server
      luajitPackages.luarocks
      marksman
      markdown-oxide
      maven
      mysql84
      nasm
      neovim
      ninja
      nodejs-slim
      pkgconf
      ripgrep
      rm-improved
      sbcl
      skim
      starship
      stylua
      taplo
      wabt
      wasmtime
      wget
      zig
      zoxide
      zsh-fast-syntax-highlighting
      nerd-fonts.meslo-lg
      alejandra
      asm-lsp
      docker-language-server
      docker-compose-language-service
      haskell-language-server
      vscode-langservers-extracted
      typescript-language-server
      zls
      tailwindcss-language-server
      phpactor
      obsidian
      neovide
      reaper
      zsh
      nil
      tailscale
      sqls
      bat
      tokei
      cargo-expand
      dockerfile-language-server-nodejs
      yaml-language-server
      # sbarlua build dependencies
      # clang
      # libllvm
      vue-language-server
      sd
      codex
      act
      direnv
      amazon-q-cli
      # sqlite
    ]
    ++ (
      if arch == "aarch64"
      then []
      else []
    )
    ++ (
      if arch == "x86_64"
      then []
      else []
    )
    ++ (
      if os == "darwin"
      then [
        mas
        pngpaste
        jankyborders
        discord
        raycast
        the-unarchiver
        utm
        betterdisplay
        chatgpt
        sketchybar
        sbarlua
        ghostty-bin
      ]
      else []
    )
    ++ (
      if os == "linux"
      then [
        firefox
        docker
        ghostty
      ]
      else []
    )
    ++ (
      if arch == "aarch64" && os == "darwin"
      then [container]
      else []
    )
    ++ (
      if arch == "x86_64" && os == "darwin"
      then []
      else []
    )
    ++ (
      if arch == "aarch64" && os == "linux"
      then [slacky]
      else []
    )
    ++ (
      if arch == "x86_64" && os == "linux"
      then [
        discord
        slack
        vital
      ]
      else []
    )
    ++ (
      if user == "a"
      then []
      else []
    )
    ++ (
      if user == "hiromichi-sugiura"
      then []
      else []
    )
    ++ (
      if user == "xsugiurah"
      then []
      else []
    )
)
