function wh --wraps='cd $(wslpath $(wslvar USERPROFILE))' --description 'alias wh cd $(wslpath $(wslvar USERPROFILE))'
    cd $(wslpath $(wslvar USERPROFILE)) $argv
end
