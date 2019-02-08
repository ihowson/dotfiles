# dotfiles

unsorted notes follow

* macos.sh gets run on new installs
* keyboard->Modifier Keys; switch caps lock to escape
* Mouse: enable tap to click
* Mouse: increase tracking speed
* Mouse: turn off ‘natural’ scroll direction
* Mouse: disable all scroll and zoom gestures
* Accessibility->Display->Cursor size: increase to about 20%


## `aulab`

I use AU Lab and Soundflower to apply some EQ to my earphones.

My daily drivers are Etymotic ER4XR, which are amazing but don't have enough bass for my taste. With a little EQ, they're perfect.

My test track is Tool "Forty Six and Two", so it's optimised to bring out the bass kick without making the bass guitar too overwhelming. Some artists have bass-heavy mixing already (e.g. Trifonic) and it's too much there.

## Vim setup

    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim +PlugInstall +qall

## Fish shell

Ubuntu 16.04 ships an oldish version of Fish which doesn't work with the enclosed prompt. To get something newer:

    sudo apt-add-repository ppa:fish-shell/release-2
    sudo apt-get update
    sudo apt-get install fish

