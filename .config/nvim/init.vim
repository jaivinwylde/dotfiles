" Sets
set termguicolors
set pumheight=5
set tabstop=4
set softtabstop=4
set shiftwidth=4
set scrolloff=15
set colorcolumn=80
set signcolumn=yes
set guicursor=
set updatetime=300
set expandtab
set nosmartindent
set autoindent
set relativenumber
set nu
set nohlsearch
set incsearch
set ignorecase
set smartcase
set hidden
set noerrorbells
set nowrap
set noswapfile
set nobackup
set nowritebackup
set nocompatible
set mouse=a

let mapleader = " "
let g:gruvbox_contrast_dark = "hard"
let g:qs_highlight_on_keys = ["f", "F", "t", "T"]
let g:python_highlight_space_errors = 0
let g:ale_fixers = {"*": ["remove_trailing_lines", "trim_whitespace"], "python": ["black"]}
let g:ale_python_black_options = "--line-length=79"
let g:ale_disable_lsp = 1
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1

" Plugins
call plug#begin("~/.config/nvim/plugins")
Plug 'ThePrimeagen/vim-be-good'

Plug 'gruvbox-community/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'sheerun/vim-polyglot'

Plug 'tmsvg/pear-tree'
Plug 'unblevable/quick-scope'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
call plug#end()

" Maps
nnoremap <leader>ps :Files<cr>
nnoremap <leader>pb :Buffer<cr>
nnoremap <leader>pg :Ag<cr>
nnoremap <leader>gs :G<cr>
nnoremap <leader>sp :set spell!<cr>
nnoremap <cr> i<cr><esc>l
cnoremap ;c <cr>:t''<cr>
cnoremap ;C <cr>:t''-1<cr>
cnoremap ;m <cr>:m''<cr>
cnoremap ;M <cr>:m''-1<cr>
cnoremap ;d <cr>dd<cr>''
nmap <leader>rn <plug>(coc-rename)
xmap <leader>a <plug>(coc-codeaction-selected)
nmap <leader>a <plug>(coc-codeaction-selected)
nmap [g <plug>(coc-diagnostic-prev-error)
nmap ]g <plug>(coc-diagnostic-next-error)
nmap <leader>gd <plug>(coc-definition)
nmap <leader>gy <plug>(coc-type-definition)
nmap <leader>gi <plug>(coc-implementation)
nmap <leader>gr <plug>(coc-references)

" Commands
command! ClearReg for i in range(34,122) | silent!
            \ call setreg(nr2char(i), []) | endfor

" Augroups
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=150}
augroup END

augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup END

" Color scheme
colorscheme gruvbox
highlight Normal guibg=#1c1c1c

" Sources
source $HOME/.config/nvim/config/coc.vim
