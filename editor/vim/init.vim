" ==============================================================================
" => Plugin manager
" ------------------------------------------------------------------------------
" ==============================================================================

call plug#begin('~/.local/share/vim/site/plugged')

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Add plugins to &runtimepath
call plug#end()

" ==============================================================================
" => Features
" ------------------------------------------------------------------------------
" These options and commands enable some very useful features in Vim, that
" no user should have to live without.
" ==============================================================================

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Enable syntax highlighting
syntax on

" ==============================================================================
" => Must have options
" ------------------------------------------------------------------------------
" These are highly recommended options.
" ==============================================================================

" 'hidden' option allows you to re-use the same window and switch from an unsaved 
" buffer without saving it first.
set hidden

" Better command-line completion
set wildmenu
 
" Show partial commands in the last line of the screen
set showcmd
 
" Highlight searches 
set hlsearch

" Enable modelines
set modeline
set modelines=5

" ==============================================================================
" => Usability options
" ------------------------------------------------------------------------------
" These are options that users frequently set in their .vimrc. Some of them
" change Vim's behaviour in ways which deviate from the true Vi way, but
" which are considered to add usability. Which, if any, of these options to
" use is very much a personal preference, but they are harmless.
" ==============================================================================

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
 
" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
 
" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent
 
" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline
 
" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2
 
" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm
 
" Use visual bell instead of beeping when doing something wrong
set visualbell
 
" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=
 
" Enable use of the mouse for all modes
set mouse=a
 
" Display line numbers on the left
set number
set relativenumber
 
" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" ==============================================================================
" => Indentation options 
" ------------------------------------------------------------------------------
" Indentation settings according to personal preference.
" ==============================================================================
 
" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4
set softtabstop=4
set expandtab

" ==============================================================================
" => Mappings
" ------------------------------------------------------------------------------
" Useful mappings
" ==============================================================================

" Map leader to comma
let mapleader = ","

" Save on ,w
noremap <leader>w :w<CR>
noremap <leader>ц :w<CR>


" Invisible Char's
if has('multi_byte')
    set listchars=tab:»\ ,trail:·,eol:¶,extends:→,precedes:←,nbsp:×
endif
nmap <leader>l :set list!<CR>


" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
        \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>


" Work with ukrainian layout
map ' `
map й q
map ц w
map у e
map к r
map е t
map н y
map г u
map ш i
map щ o
map з p
map х [
map ї ]
map ф a
map і s
map в d
map а f
map п g
map р h
map о j
map л k
map д l
map ж ;
map є '
map я z
map ч x
map с c
map м v
map и b
map т n
map ь m
map б ,
map ю .

map ʼ ~
map Й Q
map Ц W
map У E
map К R
map Е T
map Н Y
map Г U
map Ш I
map Щ O
map З P
map Х {
map Ї }
map Ф A
map І S
map В D
map А F
map П G
map Р H
map О J
map Л K
map Д L
map Ж :
map Є "
map Я Z
map Ч X
map С C
map М V
map И B
map Т N
map Ь M
map Б <
map Ю >

" Disable arrow keys
noremap <up> <NOP>
noremap <down> <NOP>
noremap <left> <NOP>
noremap <right> <NOP>
inoremap <up> <NOP>
inoremap <down> <NOP>
inoremap <left> <NOP>
inoremap <right> <NOP>

" Allow hjkl to move through wrapped lines
" noremap j gj
" noremap k gk

" Toggle NERDTree on ,n
noremap <leader>n <ESC>:NERDTreeToggle<CR>

" ==============================================================================
" => Look and feel
" ------------------------------------------------------------------------------
" ==============================================================================
colorscheme koehler
