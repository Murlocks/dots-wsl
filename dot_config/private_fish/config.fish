function removepath
    if set -l index (contains -i $argv[1] $PATH)
        set -e PATH[$index]
    end
end

if status is-interactive
    set -gx EDITOR nvim
    fish_add_path ~/.emacs.d/bin
    removepath "/mnt/c/Program Files/nodejs"
end

source ~/.local/share/lscolors.csh
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
zoxide init fish | source
fzf --fish | source
