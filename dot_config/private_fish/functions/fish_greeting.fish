# From this gist https://gist.github.com/angstbear/a0499e955ecf282c06c4a7dd9cb8bd35

function fish_greeting
    if not command -q fortune
        or not command -q cowsay
        switch (uname)
            case Darwin
                echo Installing fortune and cowsay
                brew install fortune
                sudo gem install lolcat
            case Linux
                echo Installing fortune and cowsay
                if command -q apt-get
                    sudo apt-get install fortune cowsay
                else
                    sudo yum install fortune cowsay
                end
            case '*'
                echo Wait ... where are we\? (uname), eh
        end
    end

    set -l toon (random choice {default,bud-frogs,dragon,dragon-and-cow,elephant,moose,stegosaurus,tux,vader})
    if command -q lolcat
        fortune -s | cowsay -f $toon | lolcat
    else
        fortune -s | cowsay -f $toon
    end
end
