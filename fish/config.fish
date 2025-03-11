if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting

function fish_prompt
    set_color a6adc8
    echo (pwd) (git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/')
    echo "\$ "
end
