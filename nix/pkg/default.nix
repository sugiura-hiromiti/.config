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
      dprint
      eza
      fd
      gh
      # gitui
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
      nerd-fonts.meslo-lg
      alejandra
      obsidian
      zsh
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
      amazon-q-cli
      zellij
      anki-bin
      codex
      chatgpt
      nil
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
        betterdisplay
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
        swift
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
