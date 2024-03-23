let mapleader = " "

syntax on
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smartindent
set updatetime=250
set wrap
set norelativenumber
set number
set numberwidth=1
set splitright
set splitbelow
set undofile
set noswapfile
set nobackup
set nowritebackup
set ignorecase
set smartcase
set mouse=a
set ruler
set colorcolumn=80
set termguicolors
set encoding=UTF-8
set breakindent
set showmode
set laststatus=1
set incsearch
set hlsearch
set diffopt+=vertical
set backspace=indent,eol,start
set completeopt=menuone,noselect
set scrolloff=999
set conceallevel=1

let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

nnoremap j gj
nnoremap k gk
inoremap jk <Esc>
inoremap <C-j> <Esc>
nnoremap <C-j> <Esc>
vnoremap <C-j> <Esc>
onoremap <C-j> <Esc>
nnoremap <leader>v "+p
vnoremap <leader>c "+y
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>
nnoremap <C-p> :Files<CR>
nnoremap <leader>w :w<CR>

highlight NonText ctermfg=104
hi Comment ctermfg=green
hi EndOfBuffer ctermfg=darkmagenta
