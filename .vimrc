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
Plug 'mhinz/vim-grepper'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'morhetz/gruvbox'
Plug 'ap/vim-buftabline'
Plug 'leafOfTree/vim-vue-plugin'
Plug 'jparise/vim-graphql'
Plug 'slim-template/vim-slim'
Plug 'junegunn/vim-xmark', { 'do': 'make' }
call plug#end()
"}}}

let g:python3_host_prog = '/Users/simon/.vimenv/neovim/bin/python3'

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
set nofixendofline

xnoremap <silent> p p:let @+=@0<CR>
nnoremap <CR> :nohlsearch<CR><CR>
noremap <silent> [b :call ChangeBuffer("prev")<CR>
noremap <silent> ]b :call ChangeBuffer("next")<CR>
noremap <leader>w :call ChangeBuffer("delete")<CR>

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

" {{{ change buffer function handling netrw
"from https://github.com/yangle/dotfiles/commit/d2e3962a4f1c42f32ae1fa70fb690665011f1a43
function! ChangeBuffer(direction)
    " Delete all phantom buffers created by netrw.
    " (netrw always creates two buffers, one listed and one not,
    " and the listed buffer would mess up buftabs if not deleted.)
    let l:b = 1
    while(l:b <= bufnr('$'))
        if buflisted(l:b) && getbufvar(l:b, "netrw_browser_active")
            execute ":bdelete " . l:b
        endif
        let l:b = l:b + 1
    endwhile

    " When there are multiple open windows and the current buffer is either
    " unlisted or unmodifiable, one likely just wants to close the popup.
    let l:curr = bufnr('%')
    let l:special =
        \ winnr('$') >= 2 &&
        \ (!buflisted(l:curr) || !getbufvar(l:curr, "&modifiable"))

    if l:special || a:direction == "delete"
        execute ":bdelete"
    else
        execute a:direction == "next" ? ":bnext" : ":bprev"
    endif
endfunction
" }}}

" Preserve window view when switching buffers {{{
autocmd BufLeave * call AutoSaveWinView()
autocmd BufEnter * call AutoRestoreWinView()
function! AutoSaveWinView()
    " Save current view settings on a per-window, per-buffer basis.
    if !exists("w:SavedBufView")
        let w:SavedBufView = {}
    endif
    let w:SavedBufView[bufnr("%")] = winsaveview()
endfunction
function! AutoRestoreWinView()
    " Restore current view settings.
    let buf = bufnr("%")
    if exists("w:SavedBufView") && has_key(w:SavedBufView, buf)
        let v = winsaveview()
        let atStartOfFile = v.lnum == 1 && v.col == 0
        if atStartOfFile && !&diff
            call winrestview(w:SavedBufView[buf])
        endif
        unlet w:SavedBufView[buf]
    endif
endfunction
" }}}

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
" :CocInstall coc-python
" :CocInstall coc-tsserver
" :CocInstall coc-vetur
" :CocInstall coc-json
" :CocInstall coc-prettier
" :CocInstall coc-eslint

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
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
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"   " Mappings for CoCList
"   " Show all diagnostics.
"   nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
"   " Manage extensions.
"   nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
"   " Show commands.
"   nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
"   " Find symbol of current document.
"   nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
"   " Search workspace symbols.
"   nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
"   " Do default action for next item.
"   nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
"   " Do default action for previous item.
"   nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
"   " Resume latest coc list.
"   nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

nmap <F12> :CocList outline<CR>
"}}}

" vim grepper options {{{
let g:grepper = {}
let g:grepper.tools = ["ack", "ack-grep"]
nnoremap <Leader>/ :GrepperAck -S ""<left>
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
"}}}

