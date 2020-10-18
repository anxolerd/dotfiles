" ========== Vim-Plug ========== "{{{

" auto-install vim-plug"
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin(expand('~/.local/share/nvim/plugged'))
Plug 'chriskempson/base16-vim'
Plug 'ryanoasis/vim-devicons'
Plug 'psliwka/vim-smoothie'
Plug 'vim-airline/vim-airline'
Plug 'dawikur/base16-vim-airline-themes'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

"}}}

" ========== General config ========== "{{{
set termguicolors                                               " Opaque Background
set mouse=a                                                     " enable mouse integration
set clipboard+=unnamedplus                                      " use system clipboard by default
set tabstop=4 softtabstop=4 shiftwidth=4 autoindent             " tab width
set expandtab smarttab                                          " tab key actions
set incsearch ignorecase smartcase hlsearch                     " highlight text while searching
set list listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·  " highlight ivisible chars
set encoding=utf-8                                              " encoding
set number                                                      " display line numbers
set relativenumber                                              " line numbers relative to current line
set title                                                       " tab title as file name
set emoji                                                       " better display for unicode characters
set splitright                                                  " open vertical split to the right
set splitbelow                                                  " open horizontal split to the bottom
set foldlevel=0                                                 " open all folds by default
set showtabline=2                                               " always show tabline
set grepprg=rg\ --vimgrep                                       " use rg as default grepper

" performance tweaks
set nocursorline                                                " disable cursor row highlighting
set nocursorcolumn                                              " disable cursor column highlighting
set scrolljump=5                                                " scroll 5 lines at once
set lazyredraw
set synmaxcol=180                                               " check and highlight syntax max to 180 column
set re=1                                                        " use old but fast regex engine

" required by coc
set hidden
set nobackup
set nowritebackup
set cmdheight=1
set updatetime=300
set shortmess+=c
set signcolumn=yes

" theming
colorscheme base16-summerfruit-dark
hi Comment gui=italic cterm=italic
hi clear CursorLineNr
hi CursorLineNr gui=bold

"}}}


" ========== Plugin Configuration ========== " {{{

" build in plugins
let loaded_netrw = 0                                            " disable netrw
let g:omni_sql_no_default_maps = 1                              " disable sql omni completion
let g:loaded_python_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
let g:python3_host_prog = expand('~/.pyenv/versions/neovim/bin/python3')

" Airline
let g:airline_theme='base16_summerfruit_dark'
let g:airline_skip_empty_sections = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_min_count = 2

" list of the extensions to make sure are always installed
let g:coc_global_extensions = [
            \'coc-git',
            \'coc-highlight',
            \'coc-json',
            \'coc-python',
            \'coc-syntax',
            \'coc-xml',
            \'coc-yaml',
            \]

" FZF
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'border': 'sharp' } }
let g:fzf_tags_command = 'ctags -R'

let $FZF_DEFAULT_OPTS = '--layout=reverse --inline-info'
let $FZF_DEFAULT_COMMAND = "rg --files --hidden --glob '!.git/**' --glob '!build/**' --glob '!.dart_tool/**' --glob '!.idea'"
"}}}

" ========== Custom Functions ========== " {{{
" advanced grep(faster with preview)
function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

" show docs on things with K
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
"}}}

" ========== Custom Mappings ========== " {{{
let mapleader=","

nmap <leader>r :so ~/.config/nvim/init.vim<CR>
nmap <leader>q :bd<CR>
nmap <leader>w :w<CR>
map <leader>s :Format<CR>
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprevious<CR>
noremap <leader>e :PlugInstall<CR>
noremap <C-q> :q<CR>

" new line in normal mode and back
map <Enter> o<ESC>

" FZF
nnoremap <silent> <leader>f :Files<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>c :Commands<CR>
nmap <leader>t :BTags<CR>
nmap <leader>/ :Rg<CR>
nmap <leader>gc :Commits<CR>
nmap <leader>gs :GFiles?<CR>
nmap <leader>sh :History/<CR>

" show mapping on all modes with F1
nmap <F1> <plug>(fzf-maps-n)
imap <F1> <plug>(fzf-maps-i)
vmap <F1> <plug>(fzf-maps-x)
"}}}
"
" ========== Commands ========== " {{{
au BufEnter * set fo-=c fo-=r fo-=o                             " stop annoying auto commenting on new lines
au FileType help wincmd L                                       " open help in vertical split
au BufWritePre * :%s/\s\+$//e                                   " remove trailing whitespaces before saving
au CursorHold * silent call CocActionAsync('highlight')         " highlight match on cursor hold

" spellcheck only if filetype is normal text
let spellable = ['markdown', 'gitcommit', 'txt', 'text', 'rst']
autocmd BufEnter * if index(spellable, &ft) < 0 | set nospell | else | set spell | endif

" format with available file format formatter
command! -nargs=0 Format :call CocAction('format')

" organize imports
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" files in fzf
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--inline-info']}), <bang>0)

" advanced grep
command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)
"}}}
