{
  username,
  mypkgs,
  homeDir,
  pkgs,
  ...
}: {
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
  home = {
    username = username;
    homeDirectory = homeDir;
    stateVersion = "25.11";
    # sessionVariables = {
    #   SBARLUA_DYLIB_PATH = "${pkgs.sbarlua.out}";
    # };
    file = {
      ".clang-format" = {
        target = ".clang-format";
        source = ../../../.clang-format;
      };
      ".editorconfig" = {
        target = ".editorconfig";
        source = ../../../.editorconfig;
      };
      ".gitconfig" = {
        target = ".gitconfig";
        source = ../../../.gitconfig;
      };
      ".gitconfig_p" = {
        target = ".gitconfig_p";
        source = ../../../.gitconfig_p;
      };
      ".dprint.json" = {
        target = ".dprint.json";
        source = ../../../.dprint.json;
      };
      ".rustfmt.toml" = {
        target = ".rustfmt.toml";
        source = ../../../.rustfmt.toml;
      };
      ".stylua.toml" = {
        target = ".stylua.toml";
        source = ../../../.stylua.toml;
      };
      # ".zshenv" = {
      #   target = ".zshenv";
      #   source = ../../../.zshenv;
      # };
      ".zshrc" = {
        target = ".zshrc";
        source = ../../../.zshrc;
      };
      ".npmrc" = {
        target = ".npmrc";
        source = ../../../.npmrc;
      };
      # "sshconfig" = {
      #   target = ".ssh/config";
      #   source = ../../../.ssh/config;
      # };
    };
    packages = mypkgs;
  };
  # programs = {
  #   neovim = {
  #     plugins = [
  #       {
  #         plugin = pkgs.vimPlugins.sqlite-lua;
  #         config = "let g:sqlite_clib_path = '${pkgs.sqlite.out}/lib/ibsqite3.so'";
  #       }
  #     ];
  #   };
  # };
}
