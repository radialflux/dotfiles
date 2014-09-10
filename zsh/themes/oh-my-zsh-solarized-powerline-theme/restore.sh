#! /bin/zsh

echo $old_path
# remove file
rm $theme_loc
# relink
ln -s $old_path $theme_loc
