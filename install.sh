#!/bin/bash

echo "Installing dotfiles"

echo "Initializing submodule(s)"
git submodule update --init --recursive

source install/link.sh

if [ "$(uname)" == "Darwin" ]; then
    echo "Running on OSX"

    echo "Installing homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    echo "Brewing all the things"
    source install/brew.sh

    echo "Installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    echo "Updating OSX settings"
    source install/osx.sh

    echo "Installing node (from nvm)"
    nvm install stable
    nvm alias default stable

    echo "Configuring nginx"
    # create a backup of the original nginx.conf
    mv /usr/local/etc/nginx/nginx.conf /usr/local/etc/nginx/nginx.original
    ln -s nginx/nginx.conf /usr/local/etc/nginx/nginx.conf
    # symlink the code.dev from dotfiles
    ln -s nginx/code.dev /usr/local/etc/nginx/sites-enabled/code.dev
fi

if [ "$(grep -Ei 'debian|buntu|mint' /etc/*release)" ]; then
    echo "Running a Linux distro based on Debian"

    sudo apt-get install software-properties-common
    sudo apt-get install lsb-core lsb-release

    VER_CODENAME=$(lsb_release -c | awk '{ print $2 }')

    echo "Installing curl & wget"
	sudo apt-get install curl wget

    echo "Installing ag - The Silver Searcher"
    sudo apt-get install silversearcher-ag

    echo "Installing Build Essentials"
    sudo apt-get install build-essential cmake

    echo "Installing python venv"
    sudo apt-get install python3-venv

    echo "Add and install LLVM"
    curl -L -o /tmp/llvm-snapshot.gpg.key https://apt.llvm.org/llvm-snapshot.gpg.key
    sudo apt-key add /tmp/llvm-snapshot.gpg.key
    #wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add -
    #sudo apt-add-repository "deb http://apt.llvm.org/$VER_CODENAME/ llvm-toolchain-$VER_CODENAME main"
    #sudo apt-add-repository "deb-src http://apt.llvm.org/$VER_CODENAME/ llvm-toolchain-$VER_CODENAME main"


    # Version 4
    #sudo apt repository add "deb http://apt.llvm.org/$VER_CODENAME/ llvm-toolchain-$VER_CODENAME-4.0 main"
    #sudo apt repository add "deb-src http://apt.llvm.org/$VER_CODENAME/ llvm-toolchain-$VER_CODENAME-4.0 main"
    # Version 5
    sudo apt-add-repository "deb http://apt.llvm.org/$VER_CODENAME/ llvm-toolchain-$VER_CODENAME-5.0 main"
    sudo apt-add-repository "deb-src http://apt.llvm.org/stretch/ llvm-toolchain-stretch-5.0 main"

    sudo apt-get update

    sudo apt-get install clang-5.0 lldb-5.0 lld-5.0
        
    echo "Getting prerequsites to build vim from source"
    sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev \
            libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
                libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
                    python3-dev ruby-dev lua5.1 lua5.1-dev libperl-dev git

    
    if [ ! -d ~/Software/git ]; then
        echo "Creating ~/Software/git"
        mkdir -p ~/Software/git && cd $_
        if [ ! -d ~/Software/git/vim ]; then
            echo "Cloning vim from Github"
            git clone https://github.com/vim/vim.git

            echo "Remove any existing vim installations"

            sudo apt remove vim vim-runtime gvim
            sudo apt remove vim-tiny vim-common vim-gui-common vim-nox

            PYTHON3_LIB_VER=$(python3 --version | awk '{ print $2 }' | cut -d. -f1-2)

           ./configure --with-features=huge \
                    --enable-multibyte \
                    --enable-rubyinterp=yes \
                    --enable-python3interp=yes \
                    --with-python3-config-dir=/usr/lib/$PYTHON3_LIB_VER/config \
                    --enable-perlinterp=yes \
                    --enable-luainterp=yes \
                    --enable-gui=gtk2 \
                    --enable-cscope \
                    --prefix=/usr/local
            make VIMRUNTIMEDIR=/usr/local/share/vim/vim80

            sudo apt-get install checkinstall

            sudo checkinstall
            
            echo "Setting vim as default editor"
            sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
            sudo update-alternatives --set editor /usr/bin/vim
            sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
            sudo update-alternatives --set vi /usr/bin/vim

            echo "Testing vim version"
            vim --version
         else
            echo "vim already built from source, TODO create an update script"
            #cd ~/Software/git/vim
            #git reset --hard HEAD
            #git pull
         fi	
    fi
    
    echo "Installing xclip"
    sudo apt-get install xclip

    echo "Finished Linux specific installation"
fi

echo "Installing vim plugins"
vim +PluginInstall +qall

echo "Building YouCompleteMe"
cd ~/.vim/bundle/YouCompleteMe
python3 install.py --clang-completer --system-libclang --js-completer

#echo "Configuring zsh as default shell"
#chsh -s $(which zsh)

echo "Done."
