#!/bin/bash

DOTFILES=$HOME/.dotfiles

echo "creating symlinks"
#linkables=$( ls -1 -d **/*.symlink )

if [ "$(uname)" == "Darwin" ]; then
    linkables=$( ls -1 -d **/*.symlink | sed /linux/d)
else
    echo "Must be linux remove osx tmux.conf"
    #linkables=$( ls -1 -d **/*.symlink | sed /osx/d)
    linkables=$( find . -name '*.symlink' | sed '/osx/d')

fi

echo $linkables

for file in $linkables ; do
    target="$HOME/.$( basename $file ".symlink" )"
    echo "creating symlink for $file as $target"
    if [ ! -f $target ]; then
		ln -s $DOTFILES/$file $target
    fi
done
