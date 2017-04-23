filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" syntax highlighting
syntax on
" color scheme
colorscheme molokai

" line numbers
set number
" column numbers
set ruler
" do not copy line numbers when selecting with mouse
"se mouse+=a
"se mouse=v

" vim commands go to clipboard
"set clipboard=unnamed

" vim-plug plugins
call plug#begin()
Plug 'rust-lang/rust.vim' " Rust syntax hilighting
call plug#end()

" set window navigation to alt+hjkl
nmap <silent> ˙ :wincmd h<CR>
nmap <silent> ∆ :wincmd j<CR>
nmap <silent> ˚ :wincmd k<CR>
nmap <silent> ¬ :wincmd l<CR>
"nmap <silent> <A-Left> :wincmd h<CR> "these conflict with tmux bindings
"nmap <silent> <A-Down> :wincmd j<CR>
"nmap <silent> <A-Up> :wincmd k<CR>
"nmap <silent> <A-Right> :wincmd l<CR>
" create  newly created windows on the right
set splitright

"TODO: automatically :set paste <paste> :set nopaste


