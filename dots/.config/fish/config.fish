function fish_prompt -d "Write out the prompt"
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    # $USER and $hostname are set by fish, so you can just use them
    # instead of using `whoami` and `hostname`
    printf '%s@%s %s%s%s > ' $USER $hostname \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

if status is-interactive # Commands to run in interactive sessions can go here

    # No greeting
    set fish_greeting

    # Use starship
    starship init fish | source
    if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
        cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    end

    # Aliases
    alias hamachi-start "systemctl start logmein-hamachi"
    alias hamachi-stop "systemctl stop logmein-hamachi"
    alias pamcan pacman
    alias ls 'eza --icons'
    alias clear "printf '\033[2J\033[3J\033[1;1H'"
    alias q 'qs -c ii'
#ADB
fish_add_path /home/horia/Downloads/platform-tools-latest-linux/platform-tools/
#CUDA
fish_add_path /opt/cuda/bin
#LLAMA SERVER
fish_add_path /home/horia/Documents/ik_llama/ik_llama.cpp/build/bin/
fastfetch
    
end

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /home/horia/.lmstudio/bin
# End of LM Studio CLI section


# git
set SSH_AUTH_SOCK /home/horia/.ssh/agent/s.Iocri93KC2.agent.AWUNCghZ0D
