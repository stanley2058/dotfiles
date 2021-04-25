#!/usr/bin/fish
# Env Vars
set system_logo ""
set greet_msg (echo -e "\e[34m$system_logo \e[0m") \
        (echo -e "\e[1;32m"(uname -rn)"\e[0m" \
                 "\e[1;36m"(date +"%r")"\e[0m" \
                 "\e[1;37m"(uptime -p)"\e[0m")

function fish_greeting
    echo $greet_msg
    echo (awk -f $HOME/Scripts/color-bar.awk)
end

# Bass
bass source /etc/profile
#bass source /usr/share/nvm/init-nvm.sh
bass source $HOME/.alias_profile
bass source $HOME/.env_profile

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/stanley/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

# Theme
set -g theme_display_git yes
set -g theme_display_git_dirty yes
set -g theme_display_git_untracked yes
set -g theme_display_docker_machine yes
set -g theme_display_virtualenv yes
set -g theme_color_scheme nord

### RANDOM COLOR SCRIPT ###
#colorscript random

# Init Starship
starship init fish | source
