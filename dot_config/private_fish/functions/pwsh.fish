function pwsh --wraps=pwsh.exe --description 'alias pwsh=pwsh.exe'
    wh && pwsh.exe $argv
end
