{pkgs, ...}: {
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
    };
    casks = [
      "amazon-q"
      "crystalfetch"
      "minecraft"
      "obsidian"
      "twilight"
    ];
  };
}
