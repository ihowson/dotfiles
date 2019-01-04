# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration.
source $OMF_PATH/init.fish
set -gx PATH ~/bin ~/nv/bin /usr/local/sbin /Users/ian/Library/Python/3.6/bin/ $PATH

#test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

set fish_user_paths /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin
set -x MANPATH /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/help/man /usr/local/share/man /usr/share/man /opt/x11/share/man

#eval (python3 -m virtualfish auto_activation)

export SSH_AUTH_SOCK=~/.gnupg/S.gpg-agent.ssh

alias gs="git status"
alias gs="git log"
alias gd="git diff"
alias gf="git fetch"
alias gl="git log"
alias gcom="git checkout origin/master"
alias ls="exa"
alias cat="bat -p"
alias find="echo use fd"


if grep ihowson-dt /etc/hostname
    # work desktop
    set -gx PATH ~/bin /usr/local/cuda/bin /usr/lib/ccache ~/.local/bin $PATH
    set -gx DRIVEWORKS_INSTALL_DIR $HOME/dw/sdk/build/install
    set -gx CC gcc-4.9
    set -gx CXX g++-4.9
    set -gx CUDA_BIN_PATH /usr/local/cuda/
    set -gx CCACHE_PATH /usr/bin
end

