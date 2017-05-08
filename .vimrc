" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Vundle stuff
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-syntastic/syntastic'
Plugin 'rust-lang/rust.vim'

call vundle#end()            " required
filetype plugin indent on    " required


" allow backspacing over everything in insert mode
set backspace=indent,eol,start


if has("vms")
  set nobackup      " do not keep a backup file, use versions instead
else
  set backup        " keep a backup file
endif
set ruler           " show the cursor position all the time
set showcmd         " display incomplete commands
set incsearch       " do incremental searching

" Don't use Ex mode, use Q for word wrapping
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Switch syntax highlighting on, when the terminal hascolors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent        " always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif



""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""        My changes        """""""""""
""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader=" "

" Indentation
set tabstop=4       " tab width
set softtabstop=4   " number of space deleted
set shiftwidth=4    " number of spaces inserted
set expandtab       " spaces instead of tabs

let g:loaded_matchparen=1

" Showing whitespace
set list lcs=eol:¬,trail:·,tab:▸\ 

" Invisible character colors 
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" Leader binds
nnoremap <Leader>t :set paste!<Cr>
nnoremap <Leader>r :redraw!<Cr>
nnoremap <Leader>m :0r ~/templates/competitive.cc<Cr>
"vnoremap <Leader>y "+y
nnoremap <Leader>p "+p
vnoremap <Leader>p "+p

" Change terminal title
set title

" Better tab menu
set wildmenu

" Search case-insensitive if all lowercase
set ignorecase
set smartcase

" Clear search highlighting without asdfadf
nmap <silent> ,/ :nohlsearch<CR>

" Long history
set history=1000        " command
set undolevels=1000     " undo

" Move by visual lines
noremap j gj
noremap k gk
 
" Relative line numbers
set relativenumber
set nu

function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc
nnoremap <C-n> :call NumberToggle()<cr>

" Filetype specific settings
autocmd FileType ruby setlocal tabstop=2 softtabstop=2 shiftwidth=2
"autocmd FileType python setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType make setlocal noexpandtab

" Quickly edit/reload vimrc
" let s:dot_path = expand("~/dots/.vimrc")
" if filereadable(s:dot_path)
"     let g:vimrc_loc = s:dot_path
" else
"     let g:vimrc_loc = $MYVIMRC
" endif
" 
let g:vimrc_loc = $MYVIMRC

:execute "nmap <silent> <leader>ev :tabedit" . g:vimrc_loc . "<CR>"
:execute "nmap <silent> <leader>sv :so" . g:vimrc_loc . "<CR>"
nmap <silent> <leader>eb :tabedit ~/.bashrc <CR>
nmap <silent> <leader>et :tabedit ~/.tmux.conf <CR>

" timeout length for mapping commands
set ttimeoutlen=0

" highlight columns over 80 characters
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%82v', 100) "set column nr

" scroll with cursor
nnoremap <C-j> <C-E>j
nnoremap <C-k> <C-Y>k

" intuitive placement of vim splits
set splitbelow
set splitright

" disable folds
set nofoldenable

"""""""""""""""""""""
"""""" Plugins """"""
"""""""""""""""""""""

" NERDTree
"map <silent> <C-n> :NERDTreeFocus<CR>
nnoremap <leader>f :NERDTreeFind<cr>
let NERDTreeQuitOnOpen=1

" ctrl-p
"nnoremap <Leader>o :CtrlP<Cr>

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_compiler_options = "-std=c++11 -pedantic"
let g:syntastic_python_python_exec = "/usr/bin/python3.4"
nnoremap <Leader>c :SyntasticCheck<Cr>
nnoremap <Leader>C :SyntasticReset<Cr>
autocmd VimEnter * :SyntasticToggleMode

" CommandT settings
nnoremap <Leader>o :CommandT<Cr>
let g:CommandTMaxFiles=100000
let g:CommandTFileScanner = "watchman"
let g:CommandTWildIgnore = "*.o,*.obj,*~,*.*~"
let g:CommandTTraverseSCM = "pwd"

set mouse=
