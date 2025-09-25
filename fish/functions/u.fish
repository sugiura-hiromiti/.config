function u
    pushd "$HOME/.config/nix" >/dev/null
    # build secret.nix content (note fish command substitutions)
    set who (whoami)
    set arch_raw (uname -m)
    set os_raw (uname -s)
    set arch (string replace arm aarch $arch_raw)
    set os (string lower $os_raw)
    printf "{}:\n{\n  user = \"%s\";\n  arch = \"%s\";\n  os = \"%s\";\n  home = %s;\n}\n" $who $arch $os $HOME > secret.nix
    nix run .#update
    popd >/dev/null
end
