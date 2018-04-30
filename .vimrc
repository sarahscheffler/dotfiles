"""TODO: make a shortcut to backspace all whitespace at beginning of line
""" and end up at end of prev line

"""TODO: Move neovim-only functionality to neovim config file
"""TODO: Move plugin-specific stuff to folders in .vim/plugged/

"""TODO: Keep hidden modified scratch buffer around when there are multiple buffers, to prevent exiting.

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
" Show matching brackets
set showmatch

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
set tw=79

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

" vim-plug plugins
" reload with :PlugInstall after reloading vimrc
" Update vim-plug with :PlugUpgrade
" Check for plugin upgrades with :PlugStatus
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif
call plug#begin()

Plug 'bling/vim-bufferline' " Better buffer management
Plug 'vim-airline/vim-airline' " Better statusline management
Plug 'qwertologe/nextval.vim' " Better incrementation
Plug 'vim-latex/vim-latex' " LaTeX editing features
Plug 'cespare/vim-toml' " TOML syntax hilighting
Plug 'jiangmiao/auto-pairs' " Automatically pair {}, [], etc
Plug 'tpope/vim-surround' " Surround words with quotes/braces
Plug 'rust-lang/rust.vim' " Rust syntax hilighting
"Plug 'racer-rust/vim-racer' " Rust tab completion
"let g:racer_cmd = "/Users/firechant/.cargo/bin/racer" " set racer cmd path
"let g:racer_experimental_completer = 1

Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' } "neovim language server protocol

Plug 'junegunn/fzf' "multi entry selection
Plug 'roxma/nvim-completion-manager' "completion manager for neovim
Plug 'Shougo/echodoc.vim' "function signature, inline, etc
"Plug 'neomake/neomake' "make for neovim
"call neomake#configure#automake('w') "run neomake when writing
" call neomake#configure#automake('w', 750) "same as above but also after 750ms
" call neomake#configure#automake('rw',1000) "when reading and writing

" TODO: This doesn't close when closing nvim; figure out why
function! BuildComposer(info)
    if a:info.status != 'unchanged' || a:info.force
        if has('nvim')
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

" LanguageClient integration
set hidden
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ }
let g:LanguageClient_autoStart = 1
noremap <silent> K :call LanguageClient_textDocument_hover()<CR>
noremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
noremap <silent> <F6> :call LanguageClient_textDocument_rename()<CR>

" nvim-completion-manager settings
" start newline when exiting menu
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>") 
" tab instead of enter
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>" 
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>" 

"TODO: clean up buffelrine and airline settings
" bufferline settings - currently set for statusline.
let g:bufferline_echo = 0
autocmd VimEnter *
        \ let &statusline='%{bufferline#refresh_status()}' 
        \ .bufferline#get_status_string()
"let g:buferline_solo_highlight = 1
"let g:bufferline_active_highlight = 'StatusLine'
"let g:bufferline_inactive_highlight = 'StatusLineNC'

" nextval increment with ,^ and ,v
nnoremap <Leader>v <C-x>
nnoremap <Leader>^ <C-a>

" statusline settings
let g:airline_section_z = '(%4l,%3v)  %{airline_symbols.linenr} %L'
let g:airline#extensions#default#layout = [
            \ ['a', 'c'],
            \ ['z', 'error', 'warning']
            \ ]
let g:airline#extensions#bufferline#enabled = 1
"let g:airline#extensions#bufferline#overwrite_variables = 0
let laststatus=2 "statusline appears even before split

let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
"let g:airline_theme='zerus'

