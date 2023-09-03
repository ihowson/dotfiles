set -gx PATH ~/bin ~/nv/bin /usr/local/sbin /Users/ian/Library/Python/3.10/bin $PATH

#test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

set fish_user_paths /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin
set -x MANPATH /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/help/man /usr/local/share/man /usr/share/man /opt/x11/share/man

set -x IDF_PATH ~/esp/esp-idf

set -gx PATH $PATH $HOME/.krew/bin

#eval (python3 -m virtualfish auto_activation)
eval (/opt/homebrew/bin/brew shellenv)

export SSH_AUTH_SOCK=~/.gnupg/S.gpg-agent.ssh

alias gs="git status"
alias gd="git diff"
alias gf="git fetch"
alias gcom="git checkout origin/master"
alias gl="git log"

abbr g git
abbr k kubectl

# https://gist.github.com/gerbsen/5fd8aa0fde87ac7a2cae
# content has to be in .config/fish/config.fish
# if it does not exist, create the file
setenv SSH_ENV $HOME/.ssh/environment-(hostname)

function start_agent
    echo "Initializing new SSH agent ..."
    ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
    echo "succeeded"
    chmod 600 $SSH_ENV
    . $SSH_ENV > /dev/null
    ssh-add
end

function test_identities
    ssh-add -l | grep "The agent has no identities" > /dev/null
    if [ $status -eq 0 ]
        ssh-add
        if [ $status -eq 2 ]
            start_agent
        end
    end
end

if [ -n "$SSH_AGENT_PID" ]
    ps -ef | grep $SSH_AGENT_PID | grep ssh-agent > /dev/null
    if [ $status -eq 0 ]
        test_identities
    end
else
    if [ -f $SSH_ENV ]
        . $SSH_ENV > /dev/null
    end
    ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep ssh-agent > /dev/null
    if [ $status -eq 0 ]
        test_identities
    else
        start_agent
    end
end
# --- end gist


# we don't always have powerline fonts available
set -g theme_powerline_fonts no
set -g theme_display_hostname yes

# kitty wants to use xterm-kitty here, but that breaks every remote SSH server
set -gx TERM xterm-256color

set -g fish_user_paths "/usr/local/opt/python@3.8/bin" $fish_user_paths
