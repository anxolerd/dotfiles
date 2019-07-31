" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins', 'tag': '1.2' }

" Colorscheme and UI
Plug 'joshdick/onedark.vim'
Plug 'bling/vim-airline'

" Tags management
Plug 'majutsushi/tagbar'

" Integrations
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'editorconfig/editorconfig-vim'
Plug 'prettier/vim-prettier', {
    \ 'do': 'yarn install',
    \ 'for': ['javascript', 'typescript', 'typescriptreact', 'css', 'less', 'scss'] }

" Languages support
Plug 'glench/vim-jinja2-syntax', { 'for': 'jinja' }
Plug 'mxw/vim-jsx', { 'for': 'jsx' }
Plug 'HerringtonDarkholme/yats.vim'
Plug 'dart-lang/dart-vim-plugin'

" Completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi', { 'for': 'python' }
Plug 'mhartington/nvim-typescript', { 'do': './install.sh' }

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

" ==========================
" Dart support configuration
" ==========================
let dart_html_in_string=v:true
let dart_style_guide = 2
let dart_format_on_save = 1

" ======================
" Deoplete related stuff
" ======================
let g:python_host_prog = $HOME .'/.pyenv/versions/neovim-2/bin/python'
let g:python3_host_prog = $HOME .'/.pyenv/versions/neovim-3/bin/python'
let g:tern_request_timeout = 1
let g:deoplete#enable_at_startup = 1

" ======================
" Neomake linters config
" ======================
autocmd! BufWritePost * Neomake

" ======
" Denite
" ======
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
            \ [ '.git/', '__pycache__/', 'venv/'])
call denite#custom#var('file_rec', 'command',
                      \ ['rg', '--files', '--glob', '!.git'])
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts', ['--vimgrep', '--no-heading'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

call denite#custom#option('default', 'prompt', '>')
