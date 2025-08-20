#!/usr/bin/fish

# Fish greet
function greet_title
    set system_logo ($HOME/Scripts/os-logo.sh)
    if test (uname) = Darwin
        set uptime_pretty (uptime-pretty-macos | sed -E 's/ minute[s]*/m/; s/ hour[s]*/h/; s/ day[s]*/d/; s/ week[s]*/w/; s/ year[s]*/y/')
    else
        set uptime_pretty (uptime -p | sed -E 's/ minute[s]*/m/; s/ hour[s]*/h/; s/ day[s]*/d/; s/ week[s]*/w/; s/ year[s]*/y/')
    end
    set greet_msg (printf "%s \033[1;32m%s \033[1;36m%s \033[1;37m%s \033[0m" $system_logo (uname -rn) (LC_ALL=en_US.utf8 date +"%T") $uptime_pretty)
    echo $greet_msg
end

function uptime-pretty-macos
    set boot (sysctl -n kern.boottime | awk -F'[ ,:]+' '{print $4}')
    set now (date +%s)
    set diff (math $now - $boot)

    echo $diff | awk '{
        days = int($1 / 86400)
        hours = int(($1 % 86400) / 3600)
        mins = int(($1 % 3600) / 60)

        out = "up"
        if (days > 0) {
            out = out " " days " day" (days > 1 ? "s" : "")
        }
        if (hours > 0) {
            out = out (days > 0 ? "," : "") " " hours " hour" (hours > 1 ? "s" : "")
        }
        if (mins > 0) {
            out = out ((days > 0 || hours > 0) ? "," : "") " " mins " minute" (mins > 1 ? "s" : "")
        }
        print out
    }'
end

function spark_greeting
    printf "%s" (greet_title)

    if command -v lolcat &>/dev/null
        set title_len (string length (greet_title | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g"))
        set remaining (math (tput cols) - $title_len)
        seq 1 $remaining | sort -R | spark | lolcat -b -r
    else
        echo
    end

    echo (awk -f $HOME/Scripts/color-bar.awk)
end

function fish_greeting
    spark_greeting
end

# Spark for clear
function clear
    /usr/bin/env clear
    spark_greeting
end

function notify-done
    notify-send \
        -t 5000 \
        -i gtg-task-done \
        -h 'string:desktop-entry:kitty' \
        -a 'Terminal Task Notifier' \
        'Task completed' \
        'Scheduled task done, please check for result.'
    tput bel
end

function fish_user_key_bindings
    set clear_cmd 'clear; printf "\n\n"; commandline -f repaint'
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]
        set clear_cmd 'clear; printf "\n\n\n"; commandline -f repaint'
    end

    set clear_no_scrollback "printf '\e[2J\e[3J\e[H'; $clear_cmd"

    set unipicker "unipicker --copy > /dev/null"

    bind -M insert \cu $unipicker
    bind -m insert \cu $unipicker
    bind \cu $unipicker

    bind -M insert \cl $clear_cmd
    bind -m insert \cl $clear_cmd
    bind \cl $clear_cmd

    bind -M insert \ek $clear_no_scrollback
    bind -m insert \ek $clear_no_scrollback
    bind \ek $clear_no_scrollback
end

if [ -f $HOME/.local/bin/shell-cross-env ]
    $HOME/.local/bin/shell-cross-env --to fish source /etc/profile $HOME/.env_profile $HOME/.alias_profile | source
else
    bass source /etc/profile
    bass source $HOME/.alias_profile
    bass source $HOME/.env_profile
end

function __lazy_conda --on-event fish_prompt
    # Init conda if exist
    if [ -f $HOME/miniconda3/bin/conda ]
        # >>> conda initialize >>>
        # !! Contents within this block are managed by 'conda init' !!
        eval $HOME/miniconda3/bin/conda "shell.fish" hook $argv | source
        # <<< conda initialize <<<
    end
    functions -e __lazy_conda
end

# Fish colors
set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brgreen
set fish_color_error red
set fish_color_param brcyan

# GPG TTY
set GPG_TTY (tty)

# fzf
set fzf_fd_opts --hidden --exclude=.git
function __lazy_fzf --on-event fish_prompt
    fzf_configure_bindings
    functions -e __lazy_fzf
end

# Init Starship
starship init fish | source
enable_transience

if type -q zoxide
    zoxide init --cmd cd fish | source
end
