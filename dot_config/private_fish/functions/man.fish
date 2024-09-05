function man --wraps=man --description 'alias man=nvim +hide Man'
    command nvim "+hide Man $argv"
end
