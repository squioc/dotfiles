filetype off

call plug#begin('~/.vim/bundle')

" Base Plugs
Plug 'SirVer/ultisnips'
Plug 'amix/vim-zenroom2'
Plug 'davidoc/taskpaper.vim'
Plug 'easymotion/vim-easymotion'
Plug 'ervandew/supertab'
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }
Plug 'honza/vim-snippets'
Plug 'jonhiggs/vim-readline'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/vim-peekaboo'
Plug 'kien/ctrlp.vim', { 'on': ['CtrlP', 'CtrlPMRU'] }
Plug 'matchit.zip'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'reedes/vim-lexical'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTree'] }
Plug 'scrooloose/syntastic'
Plug 'terryma/vim-multiple-cursors'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-surround'
Plug 'tyru/open-browser.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rhysd/clever-f.vim'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'chrisbra/unicode.vim'
Plug 'Raimondi/delimitMate'
Plug 'christoomey/vim-tmux-navigator'
Plug 'kana/vim-textobj-user'
Plug 'mechatroner/rainbow_csv'
Plug 'humus/code-slices.vim'

" Colorscheme Plugs
Plug 'altercation/vim-colors-solarized'
Plug 'chriskempson/tomorrow-theme'
Plug 'reedes/vim-colors-pencil'
Plug 'vim-scripts/vylight'
Plug 'tomasr/molokai'
Plug 'vim-scripts/summerfruit256.vim'
Plug 'endel/vim-github-colorscheme'

" Markup Plugs
Plug 'dagwieers/asciidoc-vim'
Plug 'plasticboy/vim-markdown'
Plug 'kurocode25/mdforvim'

" Configuration Plugs
Plug 'pearofducks/ansible-vim'
Plug 'docker/docker' , {'rtp': '/contrib/syntax/vim/'}
Plug 'nginx/nginx', {'rtp': '/contrib/vim/'}
Plug 'hashivim/vim-packer'
Plug 'hashivim/vim-consul'
Plug 'hashivim/vim-nomadproject'
Plug 'hashivim/vim-terraform'
Plug 'hashivim/vim-vagrant'
Plug 'hashivim/vim-vaultproject'
Plug 'tejr/vim-tmux'

" Languages Plugs
Plug 'sheerun/vim-json'
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'fatih/vim-go'
Plug 'othree/html5.vim'
Plug 'sheerun/yajs.vim'
Plug 'derekwyatt/vim-scala'
Plug 'gre/play2vim'

" Others Plugs
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'christoomey/vim-conflicted'
Plug 'dkprice/vim-easygrep'
Plug 'hotwatermorning/auto-git-diff'
Plug 'mattn/gist-vim'
Plug 'gregsexton/gitv', { 'on': 'Gitv' }
Plug 'jaxbot/github-issues.vim'
Plug 'sidorares/node-vim-debugger'
Plug 'tpope/vim-git'
Plug 'vim-scripts/taglist.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-projectionist' " see github.com/tpope/vim-projectionist for the config
Plug 'alvan/vim-closetag'

call plug#end()

" Syntax
syntax on
filetype indent plugin on

colorscheme solarized
set background=light

if has("gui_running")

    " Windows decoration
    set guioptions-=T
    set guioptions+=b
    set guifont=Consolas

endif

" off swap file
set noswapfile

" relative number
set relativenumber

" Change the leader key
let mapleader=","

" Define the encoding
set fileencoding=utf-8
set encoding=utf-8

" Set the status bar
set ruler
set laststatus=2

" Search
set incsearch
set smartcase

" Indentation
set autoindent
set softtabstop=4
set shiftwidth=4
set expandtab

" No wrap
set nowrap

" Show match between brackets
set showmatch

" Highlight the line under the cursor
set cursorline

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Notes configuration
let g:notes_directories = ['~/Documents/Notes']
let g:notes_suffix = '.txt'

" Markdown configurations
let g:markdown_fenced_languages = ['html', 'go', 'js', 'python', 'scala', 'bash=sh']

" github issue configurations
let g:github_access_token = ""

" Display a message
function! s:DisplayStatus(msg)
   echo a:msg
endfunction

" Make shellbang scripts executable
function! ModeChange()
    if getline(1) =~ "^#!"
        if getline(1) =~ "/bin/"
            silent !chmod a+x <afile>
        endif
    endif
endfunction

au BufWritePost * call ModeChange()

" Add shellbang to bash and python scripts
au BufNewFile *.sh,*.bash 0put=\"#!/bin/bash\<nl># -*- coding: UTF8 -*-\<nl>\<nl>\"|$
au BufNewFile *.py 0put=\"#!/usr/bin/env python\<nl># -*- coding: UTF8 -*-\<nl>\<nl>\"|$

" Apply filetypes according to filename or extension
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufReadPost todo set filetype=taskpaper


" Spelling check
function! ToggleSpell()
    if !exists("b:spell")
        setlocal spell spelllang=fr_fr
        let b:spell = 1
    else
        setlocal nospell
        unlet b:spell
    endif
endfunction

nmap <F4> :call ToggleSpell()<CR>
imap <F4> <Esc>:call ToggleSpell()<CR>a

" AutoCompletion
function! MultipleAutoCompletion()
    if &omnifunc != ''
        return "\<C-x>\<C-o>"
    elseif &dictionary != ''
        return "\<C-x>\<C-k>"
    else
        return "\<C-x>\<C-n>"
    endif
endfunction

inoremap <C-Space> <C-r>=MultipleAutoCompletion()<CR> 

function! CreateShortcut(keys, cmd, where, ...)
    let keys = "<" . a:keys . ">"
    if a:where =~ "i"
        let i = (index(a:000,"noTrailingIInInsert") > -1) ? "" : "i"
        let e = (index(a:000,"noLeadingEscInInsert") > -1) ? "" : "<esc>"
        execute "imap " . keys . " " . e . a:cmd . i
    endif
    if a:where =~ "n"
        execute "nmap " . keys . " " . a:cmd
    endif
    if a:where =~ "v"
        let k = (index(a:000,"restoreSelectionAfter") > -1) ? "gv" : ""
        let c = a:cmd
        if index(a:000,"cmdInVisual") > -1
            let c = ":<C-u>" . strpart(a:cmd,1)
        endif
        execute "vmap " . keys . " " . c . k
    endif
endfunction

call CreateShortcut("C-a", "^", "inv")
call CreateShortcut("C-e", "$", "inv")
call CreateShortcut("Home", "gg", "inv")
call CreateShortcut("End", "G", "inv")
call CreateShortcut("C-k", "dd", "in")
call CreateShortcut("C-k", "d", "v")

" Ctrl Q - Duplicate Line
call CreateShortcut("C-q", "mjyyp`jjl", "i")
call CreateShortcut("C-q", "mjyyp`jj", "n")
call CreateShortcut("C-q", "yP", "v")

" Force write on read-only files
cmap w!! w !sudo tee > /dev/null %

