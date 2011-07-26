filetype off

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Activation de la coloration syntaxique
syntax on
filetype indent plugin on

colorscheme zenburn

if has("gui_running")

    " Modification du modèle de coloration syntaxique
    " colorscheme wombat
    set guioptions-=T
    set guioptions+=b
    set guifont=Consolas

endif

" Activation de la numérotation des lignes
set number

" Modification du leader
let mapleader=","

" Définition de l'encodage des fichiers
set fileencoding=iso-8859-1

" Activation de la bar de statut
set ruler
set laststatus=2

" Recherche
set incsearch
set smartcase

" Modification de l'indentation
set autoindent
set softtabstop=4
set shiftwidth=4
set expandtab

" Pas de retour à la ligne automatique
set nowrap

" Correspondance entre les parenthese
set showmatch

" Activation du surlignage de la ligne
set cursorline

" fonction d'affichage d'un message
function! s:DisplayStatus(msg)
   echo a:msg
endfunction

" rend le fichier executable si la première ligne indique
" un interprétateur
function! ModeChange()
    if getline(1) =~ "^#!"
        if getline(1) =~ "/bin/"
            silent !chmod a+x <afile>
        endif
    endif
endfunction

au BufWritePost * call ModeChange()

au BufNewFile *.sh,*.bash 0put=\"#!/bin/bash\<nl># -*- coding: UTF8 -*-\<nl>\<nl>\"|$
au BufNewFile *.py 0put=\"#!/usr/bin/env python\<nl># -*- coding: UTF8 -*-\<nl>\<nl>\"|$


" Vérification orthographique
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

" Auto-compl�tion Multiple
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
