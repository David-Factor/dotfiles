call plug#begin()
  Plug 'reasonml-editor/vim-reason-plus'
  Plug 'neovimhaskell/haskell-vim'
  Plug 'bitc/vim-hdevtools'
  Plug 'morhetz/gruvbox'
  Plug 'w0rp/ale'
  Plug 'rust-lang/rust.vim'
  Plug 'Zaptic/elm-vim'
  Plug 'ultrox/elm-ale-pretty'
  Plug 'leafgarland/typescript-vim'
  Plug 'airblade/vim-gitgutter'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'pangloss/vim-javascript'
  Plug 'fatih/vim-go' , { 'do': ':GoUpdateBinaries' }
call plug#end()


" General
syntax on
filetype plugin indent on
set mouse=a


" Color scheme (terminal)
"set termguicolors   " enable true color support in neovim
set background=dark
let g:gruvbox_contrast_dark='soft'
colorscheme gruvbox

" UI
set cmdheight=1     " command line height
set ruler           " show the cursor position all the time
set colorcolumn=80  " add vertical line at 80 characters


" Status line
"
" see https://github.com/w0rp/ale#faq-statusline
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

set statusline=%{LinterStatus()}
set statusline+=\ ▏                   " Separator
set statusline+=%f                     " Path to the file
set statusline+=%=                    " Switch to the right side
set statusline+=\ ▏                   " Separator
set statusline+=%l                    " Current line
set statusline+=/                     " Separator
set statusline+=%L                    " Total lines
set statusline+=\ ▏                   " Separator
set statusline+=%{strftime('%H:%M')}  " Show time
set statusline+=▕                     " Separator


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
    autocmd BufRead,BufNewFile *.js setlocal filetype=javascript shiftwidth=2 tabstop=2 softtabstop=2
    autocmd BufRead,BufNewFile *.css setlocal shiftwidth=2  tabstop=2 softtabstop=2
    autocmd FileType qf setlocal linebreak brk=<
augroup END

augroup fileCleaning
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e "remove trailing spaces on save
augroup END

"" Ale
let g:ale_linters={
            \'elm': ['elm_ls'],
            \'rust': ['rls'],
            \}



let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:ale_sign_info='•'
let g:ale_lint_on_save=1
let g:ale_set_balloons=1


" Elm settings
let g:elm_format_autosave=1
let g:elm_format_fail_silently=1
let g:ale_elm_ls_elm_analyse_trigger='save'


" Rust settings
let g:rustfmt_autosave=1
let g:ale_rust_rls_toolchain='stable' " this is needed, otherwise rls uses nightly toolchain

" Go Settings
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

let g:go_fmt_command="goimports"


" Mappings
let mapleader="-"
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Ale mappings
nmap <silent> <C-k> <Plug>(ale_previous_wrap_error)
nmap <silent> <C-j> <Plug>(ale_next_wrap_error)
nmap <silent> <C-l> <Plug>(ale_next_wrap_warning)
nmap <silent> <C-d> <Plug>(ale_detail)
nmap <silent> gd <Plug>(ale_go_to_definition)
nmap <silent> gr <Plug>(ale_find_references)

" Go mappings
au Filetype go nmap <leader>ga <Plug>(go-alternate-edit)
au Filetype go nmap <leader>gah <Plug>(go-alternate-split)
au Filetype go nmap <leader>gav <Plug>(go-alternate-vertical)




" Netrw
let g:netrw_liststyle=3   " customise file explorer


" Wildmenu
set wildchar=<Tab> wildmenu wildmode=full


" fzf file fuzzy search that respects .gitignore
" If in git directory, show only files that are committed, staged, or unstaged
" else use regular :Files
" https://rietta.com/blog/2019/05/21/hide-gitignored-files-fzf-vim
nnoremap <expr> <C-p> (len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --others --cached')."\<cr>"
nnoremap <C-b> :Buffers <cr>

" Use escape in terminal mode
:tnoremap <Esc> <C-\><C-n>

" keep terminal in buffer list
augroup custom_term
	autocmd!
	autocmd TermOpen * setlocal nonumber norelativenumber bufhidden=hide
augroup END

"close the loclist window automatically when the buffer is closed.
augroup CloseLoclistWindowGroup
   autocmd!
   autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END

