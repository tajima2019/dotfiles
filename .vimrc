imap jk <Esc>
set nowritebackup
set nobackup
set wildmenu
set relativenumber

set ignorecase
set smartcase
set wrapscan
set hlsearch
set autoread

set noerrorbells
set showmatch matchtime=1
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set guioptions+=a
set showmatch
set smartindent
set noswapfile
set title
set number
set clipboard=unnamed,autoselect
syntax on

" 常に真ん中になる
set scrolloff=999

if has('persistent_undo')
  set undodir=~/.vim/undo 
  set undofile 
endif

