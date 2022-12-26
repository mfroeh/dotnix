set number         " Show numbers on the left
set relativenumber " Make all numbers relative to the current line

set tabstop=2      " Show tabs as 4 spaces
set softtabstop=2  " Delete spaces in quantities
set shiftwidth=2   " Number of spaces to use when using >> or auto indenting
set expandtab      " Insert spaces when using tabs or indenting
set autoindent     " Copies the indent from the current line when starting a new line
set smartindent    " Smarter autoindent

set incsearch      " Highlight matches whilst searching
set ignorecase     " Ignore case of letters when searching
set smartcase      " Ignore ignorecase if pattern contains uppercase characters

set termguicolors  " Use 24-bit colors

set timeoutlen=400 " Wait this many ms for mappings to complete
set ttimeoutlen=0

set hidden         " Hide buffers instead of unloading them, disables the 'No write since last change' prompt
set confirm        " Prompt to save modified buffers on save

set splitright     " Always put new window to the right of current one
set splitbelow     " Always put new window below current one

set cursorline     " Highlight entire current line

set wildmenu       " Show completions options inside command mode

let mapleader = ' '
let maplocalleader = ','

" Make Y consistent with C and D
nmap Y y$ 

" Stay in visual mode when shifting
vnoremap < <gv
vnoremap > >gv

" Center after <C-d> and <C-u>
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Set and boostrap persitent undo
if has('persistent_undo')
  set undofile " Undo persistent over sessions
  set undodir=~/.vim/undo-dir
  silent call system('mkdir -p ' . &undodir)
endif

" vim-subversive
nmap s  <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S  <plug>(SubversiveSubstituteToEndOfLine)

" vim-easy-align
nmap ga <plug>(EasyAlign)
xmap ga <plug>(EasyAlign)

" gruvbox
colorscheme gruvbox-material
set bg=dark

" vimtex
let g:vimtex_view_method = 'zathura'

" fzf
nmap <C-p> :Files<cr>
let $FZF_DEFAULT_COMMAND="find . -type f -not -path '*/\.git/*'" " Make fzf blazingly fast
