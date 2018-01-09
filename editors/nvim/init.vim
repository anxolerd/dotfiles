" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }

" Colorscheme and UI
Plug 'joshdick/onedark.vim'
Plug 'bling/vim-airline'

" Tags management
Plug 'majutsushi/tagbar'
Plug 'craigemery/vim-autotag'

" Integrations
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'editorconfig/editorconfig-vim'

" Languages support
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'glench/vim-jinja2-syntax', { 'for': ['jinja2', 'html'] }
Plug 'mxw/vim-jsx', { 'for': 'jsx' }
Plug 'posva/vim-vue', { 'for': 'vue' }
"Plug 'HerringtonDarkholme/yats.vim', { 'for': 'typescript' }
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" Completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'carlitux/deoplete-ternjs', { 'for': 'javascript', 'do': 'npm i -g tern' }
Plug 'zchee/deoplete-jedi', { 'for': 'python' }
Plug 'sebastianmarkow/deoplete-rust', { 'for': 'rust' }
Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
Plug 'mhartington/nvim-typescript', { 'for': 'typescript', 'do': 'npm i -g typescript' }

" Lints via neomake
Plug 'neomake/neomake'

" Initialize plugin system
call plug#end()

set ts=4 sw=4 sts=4 et
set colorcolumn=80
set number relativenumber
set ruler
set showcmd
set laststatus=2
set mouse=a
filetype plugin on

" Colorscheme
syntax enable
colorscheme onedark
highlight ColorColumn ctermbg=160 guibg=#D80000

" NerdTREE ignore python compiled files
let NERDTreeIgnore = ['\.pyc$', '\.mako\.py$', '^__pycache__$']

" Filetypes
augroup filetypedetect
    au BufRead,BufNewFile *.mako set filetype=html
augroup END

let mapleader = ","
noremap <Leader>w :w<CR>
imap <F2> :NERDTreeToggle<CR>
noremap <F2> :NERDTreeToggle<CR>
noremap <F3> :NERDTreeFind<CR>
nmap <F8> :TagbarToggle<CR>
nmap <C-n> :DeniteCursorWord grep<CR>
nmap <A-n> :Denite grep<CR>
nmap <C-p> :Denite buffer file_rec<CR>


autocmd FileType java setlocal omnifunc=javacomplete#Complete

let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" ======================
" Deoplete related stuff
" ======================
let g:deoplete#sources#rust#racer_binary=$HOME .'/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path=$HOME .'/workspace/rust/rust/src'
let g:python_host_prog = $HOME .'/.pyenv/versions/neovim-2/bin/python'
let g:python3_host_prog = $HOME .'/.pyenv/versions/neovim-3/bin/python'
let g:tern_request_timeout = 1
let g:tern#filetypes = ['jsx', 'javascript.jsx', 'vue']
let g:deoplete#enable_at_startup = 1

" ======================
" Neomake linters config
" ======================
let g:neomake_rust_enabled_makers = ['cargo']
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_javascript_eslint_exe = $PWD .'/node_modules/.bin/eslint'
let g:neomake_python_enabled_makers = ['flake8']
autocmd! BufWritePost * Neomake
autocmd! BufWritePost *.rs Neomake! clippy

" ======
" Denite
" ======
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
            \ [ '.git/', '__pycache__/', 'venv/'])
call denite#custom#var('file_rec', 'command',
            \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])
call denite#custom#option('default', 'prompt', '>')
