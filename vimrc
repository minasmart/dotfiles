"
"   This is the personal .vimrc of Mina Smart
"

set shell=/bin/zsh
set nocompatible
filetype off
set encoding=utf-8

" set rtp+=~/.vim/bundle/Vundle.vim
call plug#begin()

" good ones
Plug 'chriskempson/base16-vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-sleuth'
Plug 'airblade/vim-gitgutter'
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
Plug 'rizzatti/dash.vim'
" syntax
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-rails'
Plug 'mustache/vim-mustache-handlebars'
Plug 'wavded/vim-stylus'
Plug 'kchmck/vim-coffee-script'
Plug 'lukerandall/haskellmode-vim'
Plug 'guns/vim-clojure-static'
Plug 'pld-linux/vim-syntax-vcl'
Plug 'scrooloose/syntastic'
Plug 'othree/yajs.vim'
" clojure
Plug 'tpope/vim-leiningen'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-classpath'
Plug 'tpope/vim-dispatch'
Plug 'kien/rainbow_parentheses.vim'

call plug#end()

" Basics
set showcmd
set showmode
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
set statusline+=%{FugitiveStatusline()} " Git Hotness
set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info

" Autocomplete
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.

" mac home/end fixes
map [F $
imap [F $
map [H g0
imap [H g0

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
let g:syntastic_javascript_checkers = [ 'eslint' ]
autocmd FileType javascript let b:syntastic_javascript_eslint_exec = substitute(system('npm bin'), '\n\+$', '', '') . "/eslint"
autocmd FileType javascript let b:syntastic_checkers = ['eslint']
let g:syntastic_html_tidy_exec = '/opt/homebrew/bin/tidy'

" Better split navigation
nnoremap <leader>n <C-W><C-J>
nnoremap <leader>t <C-W><C-K>
nnoremap <leader>s <C-W><C-L>
nnoremap <leader>h <C-W><C-H>h

" Quick tab navigation
nmap <silent> <leader>c :tabprev<CR>
nmap <silent> <leader>r :tabnext<CR>
 
