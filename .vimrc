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

" spellcheck
set spell

" line numbers
set number
" column numbers
set ruler
" do not copy line numbers when selecting with mouse
"se mouse+=a
"se mouse=v

" term needs color scheme to agree with tmux
set term=screen-256color

" name window after vim file being edited
autocmd BufReadPost,FileReadPost,BufNewFile,BufEnter * call system("tmux rename-window 'vim:" . expand("%:t") ."'")
autocmd VimLeave * call system("tmux setw automatic-rename")

" Make backspace work like normal
set backspace=indent,eol,start

" Shift backspace backspaces everything before cursor on line and joins it with
" the preceeding line
"nmap <C-BS> <d><0><k><J>

" \s gets ready to substitute all occurrences of the word under the cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

" vim commands go to clipboard
"set clipboard=unnamed

" vim-plug plugins
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif
call plug#begin()

Plug 'cespare/vim-toml' " TOML syntax hilighting
"Plug 'jiangmiao/auto-pairs' " Automatically pair {}, [], etc
Plug 'tpope/vim-surround' " Surround words with quotes/braces
Plug 'rust-lang/rust.vim' " Rust syntax hilighting
Plug 'racer-rust/vim-racer' " Rust tab completion
let g:racer_cmd = "/Users/firechant/.cargo/bin/racer" " set racer cmd path
let g:racer_experimental_completer = 1

function! BuildComposer(info)
    if a:info.status != 'unchanged' || a:info.force
        if has('nvim') " if i ever get neo-vim lolol
            !cargo build --release
        else
            !cargo build --release --no-default-features --features json-rpc
        endif
    endif
endfunction
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') } " markdown rendering

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
"When you do, also have it turn off linewrapping while pasting


