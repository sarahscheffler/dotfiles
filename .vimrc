
"""TODO: make a shortcut to backspace all whitespace at beginning of line
""" and end up at end of prev line

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

" default linewrap 79
set tw=79

" line numbers
set number
" column numbers
set ruler
" do not copy line numbers when selecting with mouse
"se mouse+=a
"se mouse=v

" term needs color scheme to agree with tmux
set term=screen-256color

" Make backspace work like normal
set backspace=indent,eol,start

" vim commands go to clipboard
"set clipboard=unnamed

" vim-plug plugins
call plug#begin()

" Rust syntax hilighting
Plug 'rust-lang/rust.vim' 

function! BuildComposer(info)
    if a:info.status != 'unchanged' || a:info.force
        if has('nvim') " if i ever get neo-vim lolol
            !cargo build --release
        else
            !cargo build --release --no-default-features --features json-rpc
        endif
    endif
endfunction
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }

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
set splitbelow

"TODO: automatically :set paste <paste> :set nopaste


