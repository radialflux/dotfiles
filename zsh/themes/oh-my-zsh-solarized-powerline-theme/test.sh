#!/usr/bin/env zsh

theme_loc=~/.oh-my-zsh/themes/solarized-powerline.zsh-theme
# get current path
old_path="$(readlink $theme_loc)"
# delete
rm $theme_loc
# link new version
ln -s $PWD/solarized-powerline.zsh-theme $theme_loc

