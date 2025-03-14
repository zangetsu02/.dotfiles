if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting


## Useful aliases

# Replace ls with eza
alias ls 'eza -l --color=always --group-directories-first --icons'  # preferred listing
alias la 'eza -a --color=always --group-directories-first --icons'  # all files and dirs
alias lt 'eza -aT --color=always --group-directories-first --icons' # tree listing
alias l. 'eza -ald --color=always --group-directories-first --icons .*' # show only dotfiles
