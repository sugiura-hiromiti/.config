function sn
    # sk -m --ansi -ic 'rg {}' | sd ':.*' '' | xargs nvim
    # keep as-is; relies on your sk/rg/sd/xargs
    sk -m --ansi -ic 'rg {}' | sd ':.*' '' | xargs nvim
end
