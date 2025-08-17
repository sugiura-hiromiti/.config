{
  user,
  os,
  arch,
  system,
  pkgs,
  fenix,
}: (
  with pkgs;
    [
      fenix.packages.${system}.latest.toolchain
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
      zsh
      nil
      tailscale
      sqls
      bat
      tokei
      cargo-expand
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
      zellij
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
        skhd
        yabai
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
      then []
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
