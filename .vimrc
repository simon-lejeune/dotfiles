" vim: set fdm=marker fmr={{{,}}} fdl=0 :
" Plugins {{{
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-vinegar'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'nixprime/cpsm'
Plug 'mhinz/vim-grepper'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'morhetz/gruvbox'
Plug 'ap/vim-buftabline'
call plug#end()
"}}}

let g:python_host_prog = '/Users/odoo/.vimvenv/python2/.direnv/python-2.7.16/bin/python2.7'
let g:python3_host_prog = '/Users/odoo/.vimvenv/python3/.direnv/python-3.7.6/bin/python3.7'

let g:netrw_fastbrowse = 0

set autoindent                                   " plaintext files indent handling
filetype plugin indent on                        " load plugins and indent logic according to the openned file
set timeoutlen=1000 ttimeoutlen=0                " eliminate delay when hitting esc
let mapleader=" "
set mouse=a                                      " enable mouse scroll
set termguicolors

colorscheme gruvbox

set hidden
set noerrorbells visualbell t_vb=                " http://vim.wikia.com/wiki/Disable_beeping
set noshowcmd
set nobackup
set nowritebackup
set noswapfile
set undolevels=1000                              " be able to undo a lot of times
set undodir=~/.vim/undo/
set undofile
set history=1000                                 " default is 20
set wildmenu                                     " command line completion
set clipboard=unnamed                            " i should learn about registers...
set tabstop=4                                    " <tab> width is 4 columns
set shiftwidth=4                                 " << and >> indents by 4 columns
set softtabstop=4                                " tab key indents by columns
set expandtab                                    " <tab> expands to spaces, not \t
set number
set relativenumber
set colorcolumn=100
set cursorline
set showmatch                                    " show matching parenthesis
set matchtime=3
set splitright splitbelow                        " split order
set list
set listchars=tab:>·,trail:·,nbsp:¬
set incsearch                                    " jumps to word while searching
set hlsearch                                     " highlight all occurences when searching
set ignorecase                                   " ignore case when searching
set inccommand=nosplit
set tags=tags

xnoremap <silent> p p:let @+=@0<CR>
nnoremap <CR> :nohlsearch<CR><CR>
nnoremap <leader>w :bd<CR>
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>
nnoremap ]q :cnext<cr>
nnoremap [q :cprevious<cr>
tnoremap <Esc> <C-\><C-n>
nnoremap <C-]> g<C-]>
nmap <Leader>p :e ./**/
au filetype python :iabbrev pudb import pudb;pudb.set_trace()
nmap <leader>b :vs<cr>:lcd %:h<cr>:execute ":term tig blame % +" . line('.')<cr><c-w>o<cr>:execute ":cd -"<cr>i<cr>
command! Tags !ctags --exclude=./odoo/.direnv -R --fields=+l --languages=python --python-kinds=-iv -f ./tags ./odoo ./enterprise

" closing netrw buffer (https://vi.stackexchange.com/a/14633){{{
autocmd FileType netrw setl bufhidden=wipe
" }}}

" statusline {{{
set statusline=\ 
set statusline+=%f   " Path to the file
set statusline+=%w   " If we are in a preview window
set statusline+=%r   " Readonly flag
set statusline+=%m   " Modified flag
set statusline+=%=   " Switch to the right side
set statusline+=%l   " Current line
set statusline+=/    " Separator
set statusline+=%L   " Total lines
set statusline+=\ 
set statusline+=\ 
set statusline+=\ 
set statusline+=%c   " column
" }}}

" autoread and restore cursor {{{
" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
" from :h restore-cursor
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif
"}}}

" coc options {{{
set cmdheight=2                          " Better display for messages
set updatetime=300                       " You will have bad experience for diagnostic messages when it's default 4000.
set shortmess+=c                         " don't give |ins-completion-menu| messages.
set signcolumn=yes                       " always show signcolumns

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion.
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

augroup cocpython
  autocmd!
  autocmd FileType python setl formatexpr=CocAction('formatSelected')
  autocmd FileType python nnoremap <silent> K :call <SID>show_documentation()<CR>
  autocmd FileType python nmap <silent> gd <Plug>(coc-definition)
  autocmd FileType python nmap <silent> gy <Plug>(coc-type-definition)
  "autocmd FileType python nmap <silent> gi <Plug>(coc-implementation)
  autocmd FileType python nmap <silent> gr <Plug>(coc-references)
  autocmd FileType python let b:coc_root_patterns = ['.git']
  autocmd FileType python nmap <leader>rn <Plug>(coc-rename)
augroup end

augroup vue
  autocmd!
  autocmd FileType vue setl formatexpr=CocAction('formatSelected')
  autocmd FileType vue nnoremap <silent> K :call <SID>show_documentation()<CR>
  autocmd FileType vue nmap <silent> gd <Plug>(coc-definition)
  autocmd FileType vue nmap <silent> gy <Plug>(coc-type-definition)
  autocmd FileType vue nmap <silent> gi <Plug>(coc-implementation)
  autocmd FileType vue nmap <silent> gr <Plug>(coc-references)
  autocmd FileType vue nmap <leader>rn <Plug>(coc-rename)
augroup end

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')
" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

nmap <F12> :CocList outline<CR>
"}}}

" vim grepper options {{{
let g:grepper = {}
let g:grepper.tools = ["ack", "ack-grep"]
nnoremap <Leader>/ :GrepperAck -S "" --py<left><left><left><left><left><left>
nnoremap gs :Grepper -cword -noprompt<CR>
xmap gs <Plug>(GrepperOperator)
"}}}

" ctrlp options {{{
let g:ctrlp_open_new_file = 'v'
let g:ctrlp_extensions=['tag']
let g:ctrlp_working_path_mode=0   " turn off root finder
nnoremap <leader>t :CtrlPTag<cr>
nmap ; :CtrlPBuffer<cr>
if executable('rg')
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
endif
let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
let g:cpsm_match_empty_query = 0
"}}}

