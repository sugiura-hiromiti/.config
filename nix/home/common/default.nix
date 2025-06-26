{
  username,
  mypkgs,
  homeDir,
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
      ".zshenv" = {
        target = ".zshenv";
        source = ../../../.zshenv;
      };
      ".zshrc" = {
        target = ".zshrc";
        source = ../../../.zshrc;
      };
      # "sshconfig" = {
      #   target = ".ssh/config";
      #   source = ../../../.ssh/config;
      # };
    };
    packages = mypkgs;
  };
}
