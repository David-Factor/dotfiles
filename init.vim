call plug#begin()
  Plug 'neovimhaskell/haskell-vim'
  Plug 'morhetz/gruvbox'
  Plug 'w0rp/ale'
  Plug 'Zaptic/elm-vim'
  Plug 'leafgarland/typescript-vim'
call plug#end()


" General
syntax on
filetype plugin indent on
set mouse=a


" Color scheme (terminal)
set termguicolors   " enable true color support in neovim
set background=dark
colorscheme gruvbox
let g:gruvbox_contrast_dark="soft"

" UI
set cmdheight=3     " command line height
set ruler           " show the cursor position all the time
set number          " show line numbers
set colorcolumn=80  " add vertical line at 80 characters


" Visual Cues
set showmatch       "show matching brackets/braces


" Text Formatting
set autoindent      " automatic indent new lines
set nowrap          " don't wrap lines
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4


" File specific settings
augroup configGroup
    autocmd!
    autocmd BufRead,BufNewFile *.md,*.markdown setlocal wrap
    autocmd BufRead,BufNewFile *.ts setlocal filetype=typescript noexpandtab shiftwidth=2 tabstop=2
augroup END

augroup fileCleaning
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e "remove trailing spaces on save
augroup END


" Elm settings
let g:elm_format_autosave=1
let g:elm_format_fail_silently=1


" Mappings
let mapleader="-"
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Ale customisations
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <C-d> <Plug>(ale_detail)


" Netrw
let g:netrw_liststyle=3   " customise file explorer
