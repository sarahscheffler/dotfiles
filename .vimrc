"""TODO: make a shortcut to backspace all whitespace at beginning of line
""" and end up at end of prev line

"""TODO: Move neovim-only functionality to neovim config file
"""TODO: Move plugin-specific stuff to folders in .vim/plugged/

"""TODO: Keep hidden modified scratch buffer around when there are multiple buffers, to prevent exiting.

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" backspace 4 spaces at a time when tab
set softtabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
" Show matching brackets
set showmatch
" Do not wrap text that is too long
set nowrap

" Redefine <leader> to ',' because '\' is really far away
let mapleader = ","

" Always generate a filename when using grep (even for a single file)
set grepprg=grep\ -nH\ $*

" Editing empty .tex files is done as tex instead of plaintex
let g:tex_flavor='latex'

" vim-latex compiles to pdf
let g:Tex_DefaultTargetFormat='pdf'

" Redefine g:TexLeader to '#' (from '`') because it's annoying.
let g:TexLeader='#'

" syntax highlighting
syntax on
" color scheme
colorscheme molokai

" default linewrap 79
set tw=119

" spellcheck
"set spell

" line numbers
set number
" column numbers
set ruler
" do not copy line numbers when selecting with mouse
"se mouse+=a
"se mouse=v

" term needs color scheme to agree with tmux
"set term=screen-256color

" name window after vim file being edited
autocmd BufReadPost,FileReadPost,BufNewFile,BufEnter * call system("tmux rename-window 'vim:" . expand("%:t") ."'")
autocmd VimLeave * call system("tmux setw automatic-rename")

" Make backspace work like normal
set backspace=indent,eol,start

" Shift backspace backspaces everything before cursor on line and joins it with
" the preceeding line
"nmap <C-BS> <d><0><k><J>

" ,s gets ready to substitute all occurrences of the word under the cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>


" vim commands go to clipboard
"set clipboard=unnamed

" Plugins moved to nvim config! Raw vim will not use them.

" set window navigation to alt+hjkl
nmap <silent> ˙ :wincmd h<CR>
nmap <silent> ∆ :wincmd j<CR>
nmap <silent> ˚ :wincmd k<CR>
nmap <silent> ¬ :wincmd l<CR>
nmap <silent> <C-l> :bnext<CR>
nmap <silent> <C-h> :bprevious<CR>
"nmap <silent> <A-Left> :wincmd h<CR> "these conflict with tmux bindings
"nmap <silent> <A-Down> :wincmd j<CR>
"nmap <silent> <A-Up> :wincmd k<CR>
"nmap <silent> <A-Right> :wincmd l<CR>
" create  newly created windows on the right
set splitright
set splitbelow

"TODO: automatically :set paste <paste> :set nopaste
"When you do, also have it turn off linewrapping while pasting

