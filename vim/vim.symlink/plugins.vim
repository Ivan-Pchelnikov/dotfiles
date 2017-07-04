filetype off

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" let vundle manage vundle
Plugin 'gmarik/vundle'
" Colour schemes
Plugin 'chriskempson/base16-iterm2'
Plugin 'chriskempson/base16-vim'
Plugin 'altercation/vim-colors-solarized'
" Utilities
Plugin 'vim-scripts/vim-auto-save'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
" Fuzzy search
Plugin 'kien/ctrlp.vim'
" Snippets
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
" Track the engine.
Plugin 'SirVer/ultisnips'

" Optional:
Plugin 'honza/vim-snippets'
" Reactjs
Plugin 'justinj/vim-react-snippets'
" languages
Plugin 'tpope/vim-markdown'
" Javascript -  some from referenced from Joyent
Plugin 'moll/vim-node'
Plugin 'godlygeek/tabular'
" Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'burnettk/vim-angular'
"Plugin 'othree/javascript-libraries-syntax.vim'
" Zen Coding
Plugin 'mattn/emmet-vim'
" Code Commenting
Plugin 'tpope/vim-commentary'
" Editor Config
Plugin 'editorconfig/editorconfig-vim'
" Search and replace
Plugin 'henrik/vim-qargs'
" JavaScript Beautify
"Plugin 'maksimr/vim-jsbeautify'
"Plugin 'einars/js-beautify'
Plugin 'Chiel92/vim-autoformat'
Plugin 'leafgarland/typescript-vim'
Plugin 'Shougo/unite.vim'
Plugin 'Quramy/vim-dtsm'
Plugin 'Shougo/vimproc.vim'
Plugin 'Quramy/tsuquyomi'
Plugin 'Quramy/vim-js-pretty-template'
Plugin 'jason0x43/vim-js-indent'
Plugin 'reedes/vim-pencil'
Plugin 'Valloric/YouCompleteMe'
Plugin 'HerringtonDarkholme/yats.vim'
Plugin 'vim-scripts/SyntaxComplete'

call vundle#end()

filetype plugin indent on

