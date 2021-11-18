" Sets
set hidden
set termguicolors
set pumheight=5
set tabstop=4
set softtabstop=4
set shiftwidth=4
set scrolloff=15
set colorcolumn=80
set signcolumn=yes
set guicursor=
set updatetime=100
set expandtab
set nosmartindent
set autoindent
set relativenumber
set nu
set nohlsearch
set incsearch
set ignorecase
set smartcase
set noerrorbells
set nowrap
set noswapfile
set nobackup
set nowritebackup
set nocompatible
set mouse=a
set guicursor+=a:blinkon0

let mapleader = " "
let g:gruvbox_contrast_dark = "hard"
let g:qs_highlight_on_keys = ["f", "F", "t", "T"]
let g:python_highlight_space_errors = 0
let g:smoothie_enabled = 1
let g:smoothie_speed_constant_factor = 48
let g:user_emmet_leader_key = "<c-e>"
let g:user_emmet_settings = {
\  "javascript" : {
\      "extends": "jsx",
\  },
\}
let g:polyglot_disabled = ["markdown"]
let g:fern#disable_default_mappings   = 1
let g:fern#disable_drawer_auto_quit   = 1
let g:fern#disable_viewer_hide_cursor = 1
let g:fern#renderer = "nerdfont"

" Plugins
call plug#begin("~/.config/nvim/plugins")
Plug 'gruvbox-community/gruvbox'
Plug 'hoob3rt/lualine.nvim'
Plug 'sheerun/vim-polyglot'
Plug 'psliwka/vim-smoothie'

Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-hijack.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'artnez/vim-wipeout'

Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

Plug 'mattn/emmet-vim'
Plug 'tmsvg/pear-tree'
Plug 'unblevable/quick-scope'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

lua <<EOF
require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox_material',
    component_separators = {'', ''},
    section_separators = {'', ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
EOF

" Maps
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv
nnoremap Y y$
nnoremap <c-l> :tabn<cr>
nnoremap <c-h> :tabp<cr>
nnoremap <leader>sp :set spell!<cr>
nnoremap <cr> i<cr><esc>l
cnoremap ;c <cr>:t''<cr>
cnoremap ;C <cr>:t''-1<cr>
cnoremap ;m <cr>:m''<cr>
cnoremap ;M <cr>:m''-1<cr>
cnoremap ;d <cr>dd<cr>''

imap <c-e> <plug>(emmet-expand-abbr)

nnoremap <leader>cl :Wipeout<cr>

noremap <silent> <leader>nt :Fern . -drawer -width=35 -toggle<cr>
noremap <silent> <leader>nf :Fern . -drawer -reveal=% -width=35<cr>

nnoremap <expr> <leader>ps (len(system('git rev-parse')) ? ':Files' : ':GFiles')."\<cr>"
nnoremap <leader>pb :Buffer<cr>
nnoremap <leader>pg :Ag<cr>

nnoremap <leader>gs :G<cr>

nmap <leader>rn <plug>(coc-rename)
xmap <leader>a <plug>(coc-codeaction-selected)
nmap <leader>a <plug>(coc-codeaction-selected)
nmap [g <plug>(coc-diagnostic-prev-error)
nmap ]g <plug>(coc-diagnostic-next-error)
nmap <leader>gd <plug>(coc-definition)
nmap <leader>gy <plug>(coc-type-definition)
nmap <leader>gi <plug>(coc-implementation)
nmap <leader>gr <plug>(coc-references)

" Functions
function! FernInit() abort
  nmap <buffer><expr>
        \ <plug>(fern-my-open-expand-collapse)
        \ fern#smart#leaf(
        \   "\<plug>(fern-action-open:select)",
        \   "\<plug>(fern-action-expand)",
        \   "\<plug>(fern-action-collapse)",
        \ )
  nmap <buffer> o <plug>(fern-my-open-expand-collapse)
  nmap <buffer> t <plug>(fern-action-mark:toggle)j
  nmap <buffer> n <plug>(fern-action-new-path)
  nmap <buffer> d <plug>(fern-action-remove)
  nmap <buffer> m <plug>(fern-action-rename)
  nmap <buffer> s <plug>(fern-action-open:split)
  nmap <buffer> v <plug>(fern-action-open:vsplit)
  nmap <buffer> r <plug>(fern-action-reload)
  nmap <buffer> <nowait> h <plug>(fern-action-hidden:toggle)
  nmap <buffer> <nowait> < <plug>(fern-action-leave)
  nmap <buffer> <nowait> > <plug>(fern-action-enter)
endfunction

" Commands
command! ClearReg for i in range(34,122) | silent!
            \ call setreg(nr2char(i), []) | endfor

" Augroups
augroup FernEvents
  autocmd!
  autocmd FileType fern call FernInit()
augroup END

augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=150}
augroup END

augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup END

augroup format
  autocmd!
  autocmd BufWritePre * silent call CocAction("format")
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END

" Color scheme
colorscheme gruvbox
highlight Normal guibg=#1c1c1c

" Sources
source $HOME/.config/nvim/config/coc.vim
