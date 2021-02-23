set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc


"let g:plugs_disabled = ['vim-markdown-composer']
"function! plug_disable#commit()
  "for name in g:plugs_disabled
    "if has_key(g:plugs, name)
      "call remove(g:plugs, name)
    "endif
"
    "let idx = index(g:plugs_order, name)
    "if idx > -1
      "call remove(g:plugs_order, idx)
    "endif
  "endfor
"endfunction

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif
call plug#begin()

Plug 'bling/vim-bufferline' " Better buffer management
Plug 'vim-airline/vim-airline' " Better statusline management
Plug 'qwertologe/nextval.vim' " Better incrementation
"Plug 'vim-latex/vim-latex' " LaTeX editing features -- has gross mappings.  disabled.
Plug 'LaTeX-Box-Team/LaTeX-Box' " LaTeX editing features
Plug 'cespare/vim-toml' " TOML syntax hilighting
Plug 'jiangmiao/auto-pairs' " Automatically pair {}, [], etc
Plug 'tpope/vim-surround' " Surround words with quotes/braces
Plug 'rust-lang/rust.vim' " Rust syntax hilighting
"Plug 'racer-rust/vim-racer' " Rust tab completion
"let g:racer_cmd = "/Users/firechant/.cargo/bin/racer" " set racer cmd path
"let g:racer_experimental_completer = 1
Plug 'junegunn/fzf' "multi entry selection
Plug 'Shougo/echodoc.vim' "function signature, inline, etc
Plug 'kshenoy/vim-signature' "show marks
Plug 'neomake/neomake' "Linting for C++
Plug 'metakirby5/codi.vim' "Scratchpad
Plug 'mechatroner/rainbow_csv' "Rainbow CSV

" Workaround for wl-clipboard bug on opening folders:
" Enable system clipboard integration
"set clipboard+=unnamedplus
" Workaround for neovim wl-clipboard and netrw interaction hang 
" (see: https://github.com/neovim/neovim/issues/6695 and https://github.com/neovim/neovim/issues/9806) 
let g:clipboard = {
      \   'name': 'myClipboard',
      \   'copy': {
      \      '+': 'wl-copy',
      \      '*': 'wl-copy',
      \    },
      \   'paste': {
      \      '+': 'wl-paste -o',
      \      '*': 'wl-paste -o',
      \   },
      \   'cache_enabled': 0,
      \ }

" neovim language server protocol
"Plug 'autozimu/LanguageClient-neovim', { 
            "\ 'branch': 'next',
            "\ 'do': 'bash install.sh',
            "\ }

"Plug 'roxma/nvim-completion-manager' "completion manager for neovim
"Plug 'neomake/neomake' "make for neovim
"call neomake#configure#automake('w') "run neomake when writing
" call neomake#configure#automake('w', 750) "same as above but also after 750ms
" call neomake#configure#automake('rw',1000) "when reading and writing

" TODO: This doesn't close when closing nvim; figure out why
"function! BuildComposer(info)
    "if a:info.status != 'unchanged' || a:info.force
        "if has('nvim')
            "!cargo build --release
        "else
            "!cargo build --release --no-default-features --features json-rpc
        "endif
    "endif
"endfunction
"let g:markdown_composer_custom_css = ["file:///Users/firechant/dotfiles/css_for_vmc.css"] " custom css
"Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') } " markdown rendering

call plug#end()




" Codi shortcuts
let g:codi#interpreters = {
    \ 'python3': {
        \ 'bin': 'python3',
        \ 'prompt': '^\(>>>\|\.\.\.\) ',
        \ },
    \ }

let g:codi#aliases = {
    \ 'py3': 'python3',
    \ }

"" LanguageClient integration
set hidden
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'markdown': ['mdpls']
    \ }
let g:LanguageClient_autoStart = 1
noremap <silent> K :call LanguageClient_textDocument_hover()<CR>
noremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
noremap <silent> <F6> :call LanguageClient_textDocument_rename()<CR>

"" nvim-completion-manager settings
"" start newline when exiting menu
"inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>") 
"" tab instead of enter
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>" 
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>" 
"
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


" Neomake settings
function! MyOnBattery()
  if has('macunix')
    return match(system('pmset -g batt'), "Now drawing from 'Battery Power'") != -1
  elsif has('unix')
    return readfile('/sys/class/power_supply/AC/online') == ['0']
  endif
  return 0
endfunction

if MyOnBattery()
  call neomake#configure#automake('w')
else
  call neomake#configure#automake('nw', 0)
endif
nnoremap <M-.> :lnext<Enter>
nnoremap <M-,> :lprev<Enter>
