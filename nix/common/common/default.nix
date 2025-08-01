# common/common
{pkgs}: [
  pkgs.git
  pkgs.curl
  pkgs.chibi
  pkgs.deno
  pkgs.dosfstools
  pkgs.dprint
  pkgs.eza
  pkgs.fd
  pkgs.gh
  pkgs.gitui
  pkgs.go
  # pkgs.jdk
  pkgs.jdk11
  pkgs.google-java-format
  pkgs.gopls
  pkgs.graphviz
  pkgs.jdt-language-server
  pkgs.lua5_4_compat
  pkgs.lua-language-server
  pkgs.luajitPackages.luarocks
  pkgs.marksman
  pkgs.markdown-oxide
  pkgs.maven
  pkgs.mysql84
  pkgs.nasm
  pkgs.neovim
  pkgs.ninja
  pkgs.nodejs-slim
  pkgs.pkgconf
  pkgs.ripgrep
  pkgs.rm-improved
  pkgs.sbcl
  pkgs.skim
  pkgs.starship
  pkgs.stylua
  pkgs.taplo
  pkgs.wabt
  pkgs.wasmtime
  pkgs.wget
  pkgs.zig
  pkgs.zoxide
  pkgs.zsh-fast-syntax-highlighting
  pkgs.nerd-fonts.meslo-lg
  pkgs.alejandra
  pkgs.asm-lsp
  pkgs.docker-language-server
  pkgs.docker-compose-language-service
  pkgs.haskell-language-server
  pkgs.vscode-langservers-extracted
  pkgs.typescript-language-server
  pkgs.zls
  pkgs.tailwindcss-language-server
  pkgs.phpactor
  pkgs.obsidian
  pkgs.neovide
  pkgs.reaper
  pkgs.zsh
  # pkgs.binutils
  pkgs.nil
  pkgs.tailscale
  pkgs.sqls
  pkgs.bat
  pkgs.tokei
  pkgs.cargo-expand
  pkgs.dockerfile-language-server-nodejs
  pkgs.yaml-language-server
  # pkgs.postgres-lsp
  # these 2 packages are required to build sbarlua
  # pkgs.clang
  # pkgs.libllvm
  pkgs.vue-language-server
  pkgs.sd
  pkgs.codex
  pkgs.act
  pkgs.direnv
  pkgs.amazon-q-cli
  # pkgs.sqlite
]
