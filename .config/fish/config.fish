#!/usr/bin/fish

# Fish greet
function fish_greeting
    set system_logo ""
    set greet_msg (printf "\033[34m%s \033[1;32m%s \033[1;36m%s \033[1;37m%s \033[0m" $system_logo (uname -rn) (date +"%r") (uptime -p))
    printf "%s\n%s\n" $greet_msg (awk -f $HOME/Scripts/color-bar.awk)
end

# Spark for clear
alias clear='/usr/bin/env clear; seq 1 (tput cols) | sort -R | spark | lolcat'
function fish_user_key_bindings
    bind \cl 'clear; echo; echo; commandline -f repaint'
end

# Bass
bass source /etc/profile
bass source $HOME/.alias_profile
bass source $HOME/.env_profile

# Init conda if exist
if [ -f $HOME/miniconda3/bin/conda ]
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    eval $HOME/miniconda3/bin/conda "shell.fish" "hook" $argv | source
    # <<< conda initialize <<<
end

# Env vars
set -U FZF_LEGACY_KEYBINDINGS 0

# Fish colors
set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brgreen
set fish_color_error red
set fish_color_param brcyan


# Init Starship
starship init fish | source
