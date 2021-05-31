" Sets
set lazyredraw
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
set hidden
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

" Plugins
call plug#begin("~/.config/nvim/plugins")
Plug 'ThePrimeagen/vim-be-good'

Plug 'gruvbox-community/gruvbox'
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'psliwka/vim-smoothie'

Plug 'tmsvg/pear-tree'
Plug 'unblevable/quick-scope'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
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

" Functions
function! CloseHiddenBuffers()
  " Figure out which buffers are visible in any tab
  let visible = {}
  for t in range(1, tabpagenr('$'))
    for b in tabpagebuflist(t)
      let visible[b] = 1
    endfor
  endfor
  " Close any buffer that's loaded and not visible
  for b in range(1, bufnr('$'))
    if bufloaded(b) && !has_key(visible, b)
      exe 'bd ' . b
    endif
  endfor
endfun

" Maps
nnoremap <leader>cb :call CloseHiddenBuffers()<cr>
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

augroup format
  autocmd!
  autocmd BufWritePre * silent call CocAction("format")
augroup END

" Color scheme
colorscheme gruvbox
highlight Normal guibg=#1c1c1c

" Sources
source $HOME/.config/nvim/config/coc.vim
