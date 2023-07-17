# dotfiles

unsorted notes follow

* macos.sh gets run on new installs
* keyboard->Modifier Keys; switch caps lock to escape
* Mouse: enable tap to click
* Mouse: increase tracking speed
* Mouse: turn off ‘natural’ scroll direction
* Mouse: disable all scroll and zoom gestures
* Accessibility->Display->Cursor size: increase to about 20%

## Vim setup

    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim +PlugInstall +qall

## Fish shell

Ubuntu 16.04 ships an oldish version of Fish which doesn't work with the enclosed prompt. To get something newer:

    sudo apt-add-repository ppa:fish-shell/release-2
    sudo apt-get update
    sudo apt-get install fish

