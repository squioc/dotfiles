filetype off

call plug#begin('~/.vim/bundle')

" Base Plugs
Plug 'easymotion/vim-easymotion'
Plug 'yegappan/mru'
Plug 'ervandew/supertab'
Plug 'junegunn/vim-peekaboo'
Plug 'adelarsq/vim-matchit'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTree'] }
Plug 'ryanoasis/vim-devicons'
Plug 'vim-syntastic/syntastic'
Plug 'terryma/vim-multiple-cursors'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chrisbra/unicode.vim'
Plug 'Raimondi/delimitMate'
Plug 'kana/vim-textobj-user'

" Writing Plugs
Plug 'amix/vim-zenroom2'
Plug 'reedes/vim-lexical'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }

" Text Plug
Plug 'davidoc/taskpaper.vim'
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }
Plug 'vimwiki/vimwiki'

" Colorscheme Plugs
Plug 'altercation/vim-colors-solarized'
Plug 'chriskempson/tomorrow-theme', { 'rtp' : 'vim' }
Plug 'reedes/vim-colors-pencil'
Plug 'vim-scripts/vylight'
Plug 'tomasr/molokai'
Plug 'vim-scripts/summerfruit256.vim'
Plug 'endel/vim-github-colorscheme'
Plug 'rakr/vim-one'

" Markup Plugs
Plug 'dagwieers/asciidoc-vim'
Plug 'plasticboy/vim-markdown'

" Configuration Plugs
Plug 'docker/docker' , {'rtp': '/contrib/syntax/vim/'}

" Languages Plugs
Plug 'sheerun/vim-json'
Plug 'stephpy/vim-yaml'
Plug 'fatih/vim-go'
Plug 'othree/html5.vim'
Plug 'sheerun/yajs.vim'
Plug 'w0rp/ale'
Plug 'ambv/black'
Plug 'Chiel92/vim-autoformat'
Plug 'integralist/vim-mypy'

" Others Plugs
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'christoomey/vim-conflicted'
Plug 'dkprice/vim-easygrep'
Plug 'hotwatermorning/auto-git-diff'
Plug 'vim-scripts/taglist.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'alvan/vim-closetag'
Plug 'bfrg/vim-jqplay'
Plug 'wfxr/minimap.vim'

call plug#end()

" Syntax
syntax on
filetype indent plugin on

colorscheme peachpuff
set background=dark

if has("gui_running")

    " Windows decoration
    set guioptions-=T
    set guioptions+=b
    set guifont=HackNerdFontComplete-Regular:h11
    set background=light
    colorscheme Tomorrow

endif

" off swap file
set noswapfile

" relative number
set relativenumber

" line number
set number

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

" Notes configuration
let g:vimwiki_list = [{'path': '~/notes/wiki',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

" Markdown configurations
let g:markdown_fenced_languages = ['html', 'go', 'js', 'python', 'scala', 'bash=sh']

" language-tool
" let g:syntastic_text_checkers = ['language_check']
" let g:syntastic_text_language_check_args = '--language=en-US'
let g:syntastic_markdown_checkers = ['language_check']
let g:syntastic_markdown_language_check_args = '--language=en-US'

" NERDTree
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
nnoremap <silent> <C-b> :NERDTreeToggle<CR>

" Taglist
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Use_Right_Window = 1
nnoremap <C-c> :TlistToggle<CR>

" Undotree
let g:undotree_WindowLayout = 'style 3'
nnoremap <C-h> :UndotreeToggle<CR>

" Minimap
nnoremap <C-m> :MinimapToggle

" Terminal
" open new split panes to right and below
set splitright
set splitbelow

" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>

" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif

" open terminal on ctrl+n
function! OpenTerminal()
  term
  resize 10
endfunction
nnoremap <c-t> :call OpenTerminal()<CR>

nnoremap <C-p> :FZF<CR>
let g:fzf_action = {
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

" Make shellbang scripts executable
function! ModeChange()
    if getline(1) =~ "^#!"
        if getline(1) =~ "/bin/"
            silent !chmod a+x <afile>
        endif
    endif
endfunction

" au BufWritePost * call ModeChange()

" Add shellbang to bash and python scripts
au BufNewFile *.sh,*.bash 0put=\"#!/bin/bash\<nl># coding: utf-8 \<nl>\<nl>\"|$
au BufNewFile *.py 0put=\"#!/usr/bin/env python\<nl># coding: utf-8 \<nl>\<nl>\"|$

" Apply filetypes according to filename or extension
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufReadPost todo set filetype=taskpaper
autocmd BufNewFile,BufReadPost *.tsv set filetype=tsv

" Check python script with Flake8 on write
autocmd BufWritePost *.py call Flake8()

" Format xml
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

" Format json
au FileType json setlocal equalprg=jq\ .\ -\ 2>/dev/null

" Format yaml
au FileType yaml setlocal equalprg=yq\ .\ -\ 2>/dev/null

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

