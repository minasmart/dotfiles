"
"   This is the personal .vimrc of Mina Smart
"

set shell=/bin/zsh
set nocompatible
set encoding=utf-8

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" Plugin
Plugin 'gmarik/vundle'
" good ones
Plugin 'chriskempson/base16-vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-sleuth'
Plugin 'airblade/vim-gitgutter'
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'
Plugin 'rizzatti/dash.vim'
" syntax
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-rails'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'wavded/vim-stylus'
Plugin 'kchmck/vim-coffee-script'
Plugin 'lukerandall/haskellmode-vim'
Plugin 'guns/vim-clojure-static'
Plugin 'pld-linux/vim-syntax-vcl'
Plugin 'file:///Users/msmart/Projects/personal/rust.vim/'
Plugin 'scrooloose/syntastic'
Plugin 'othree/yajs.vim'
Plugin 'mxw/vim-jsx'
Plugin 'elixir-lang/vim-elixir'
" clojure
Plugin 'tpope/vim-leiningen'
Plugin 'tpope/vim-fireplace'
Plugin 'tpope/vim-classpath'
Plugin 'tpope/vim-dispatch'
Plugin 'kien/rainbow_parentheses.vim'

" Basics
syntax enable
set showcmd
set showmode
filetype plugin indent on
set nu " Line numbers on
set showmatch " Show matching brackets/parenthesis
set spell
set history=1000
set backup " backup current file
set splitright
set splitbelow
set mouse=a
set clipboard=unnamed
let mapleader=','
set pastetoggle=<leader>p
set t_Co=256
let base16colorspace=256
set background=dark
colorscheme base16-eighties

" This fixes inlined html
command Xmlbreak %s/></>\r</g

" Dvorak nav
noremap h h
noremap n gj
noremap t gk
noremap s l
" Others
noremap L n
noremap l N
noremap - $
noremap _ ^
"noremap o :
"noremap O :

" Always work out of cwd
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

" Whitespace
set nowrap
set ts=2
set sw=2
set expandtab
set softtabstop=2
set autoindent
set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set listchars=tab:,.,trail:.,extends:#,nbsp:. " Highlight problematic whitespace
set list

" Searching
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present

" Undo
set undodir=$HOME/.vimundo
set undofile
set undolevels=1000
set undoreload=10000

" Backup
set backupdir=~/.vimbackup
set directory=~/.vimswap.,~/tmp,/var/tmp,/tmp

" Visual editing
set cursorline
set ruler
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set colorcolumn=80
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%121v.\+/

" Statusline
set laststatus=2
set statusline=[%{getcwd()}/%F]          " Current dir
set statusline+=%{fugitive#statusline()} " Git Hotness
set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info

" Autocomplete
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.

" mac home/end fixes
map [F $
imap [F $
map [H g0
imap [H g0

" Rainbow parens
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Wrap markdown
au BufRead,BufNewFile *.md setlocal textwidth=80

" Haskell settings
let g:haddock_browser = "open"

" Extension aliases
au BufNewFile,BufRead *.es6 set filetype=javascript

" Easier than typing SyntasticCheck
nmap <silent> <leader>c :SyntasticCheck<CR>
let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_javascript_checkers = [ 'eslint', 'jshint' ]
autocmd FileType javascript let b:syntastic_checkers = findfile('.eslintrc', '.;') != '' ? ['eslint'] : ['standard']

" Better split navigation
nnoremap <leader>n <C-W><C-J>
nnoremap <leader>t <C-W><C-K>
nnoremap <leader>s <C-W><C-L>
nnoremap <leader>h <C-W><C-H>h

" Quick tab navigation
nmap <silent> <leader>c :tabprev<CR>
nmap <silent> <leader>r :tabnext<CR>
