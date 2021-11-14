" , -> vim and go
" ctrl -> tmux
" cmd -> macOS
"
" dif -> delete inner function
" vif -> select inner function
" daf -> delete outer function
" vaf -> sekect outer function
" gS -> put in multiline struct properties, etc.
" gJ -> put multiline struct in single line
" ctrl + o -> jumps to the previous cursor location
" leader s -> show variable usages
" leader ss -> hide variable usages
" leader + fs -> create new vertical split

" keyboard shortcuts
let mapleader = ','
let maplocalleader = ','

autocmd VimEnter * call StartUp()

" Move selected lines around
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

nnoremap <leader>. :nohlsearch<CR> " Remove search highlight
nnoremap <leader>w :w!<CR> " Fast saving
noremap <C-d> <C-d>zz " Same when moving down
noremap <C-u> <C-u>zz " Same when moving up

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Remap H and L (top, bottom of screen to left and right end of line)
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L g_

vnoremap p "_dP " Don't copy the contents of an overwritten selection

nnoremap <space> zz " Center the screen

" Bash like keys for the command line
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>

" Visual linewise up and down by default (and use gj gk to go quicker)
noremap j gj
noremap k gk

imap jj <Esc> " Exit on j

" arrow keys resize windows
nnoremap <Left> :vertical resize -10<CR>
nnoremap <Right> :vertical resize +10<CR>
nnoremap <Up> :resize -10<CR>
nnoremap <Down> :resize +10<CR>

" Quickfix window open in split vertical window with 's'
autocmd! FileType qf nnoremap <buffer> s <C-w><Enter><C-w>L

" Print full path
map <C-f> :echo expand("%:p")<cr>

" Swap begin of line keys for easy acces
noremap 0 ^
noremap ^ 0

" format/indent whole file keeping cursor at the same position
noremap =a gg=G<C-o><C-o>

" Keep cursor at the bottom of the visual selection after you yank it.
vmap y ygv<Esc>

" Prevent x from overriding what's in the clipboard.
noremap x "_x
noremap X "_x

" http://vimdoc.sourceforge.net/htmldoc/filetype.html#:filetype-indent-on
" Indent based on typeFile --> loads the file "indent.vim" in 'runtimepath
filetype plugin indent on

set nocompatible " Don't bother with vi compatibility
set mouse=
set autoread                                                 " Reload files when changed on disk, i.e. via `git checkout`
set autoindent                                               " Automatically indent on new lines
set backspace=indent,eol,start                               " Makes backspace key more powerful
set backupcopy=yes                                           " Make a copy of the file and overwrite the original one (default backup paths: .,~/tmp,~/) http://vimdoc.sourceforge.net/htmldoc/options.html#'backupcopy'
set nobackup                                                 " Don't create annoying backup files
set directory-=.                                             " Don't store swapfiles in the current directory
set splitright                                               " When on, splitting a window will put the new window right of the current one (:vsplit)
set noswapfile                                               " Don't use swapfiles
set encoding=utf-8
set expandtab                                                " Make tab made of spaces
set ignorecase                                               " Case-insensitive search
set smartcase                                                " Case sensitive when upper letter
set incsearch                                                " Search as you type with /
set laststatus=2                                             " Always show statusline
set listchars=trail:▫                                        " Show all the trailing spaces (spaces at the end of a line)
set number                                                   " Show column numbers
set ruler                                                    " Show where you are in the status bar (it displays the line number, the column number, the virtual column number, and the relative position of the cursor in the file)
set scrolloff=3                                              " Show context above/below cursorline
set shiftwidth=2                                             " Default identation when brackets opened, etc.
set softtabstop=2                                            " Number of spaces equivalent to tab and backspace
set tabstop=2                                                " Actual tabs occupy 4 characters
set showcmd                                                  " Show me what I'm typing
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmenu                                                 " Show a navigable menu for tab completion for vim commands
set wildmode=longest,list,full
set autowrite                                                " Automatically save before :next, :make etc.
set nocursorcolumn                                           " Speed up syntax highlighting
set nocursorline
set pumheight=10                                             " Max number of items to show in the popup menus for completion
set conceallevel=2                                           " Concealed text is completely hidden
set hlsearch                                                 " highlight search
set autowrite
set nowritebackup
set whichwrap+=<,>,h,l,[,]                                   " Wrap arrow keys between lines
set shortmess+=c                                             " Shut off completion messages
set belloff+=ctrlg                                           " If Vim beeps during completion
set cursorline                                               " highlight current line
set pastetoggle=<F5>                                         " Toggle paste mode
set splitright                                               " vim split on the right always
set clipboard^=unnamed
set clipboard^=unnamedplus

" fdoc is yaml
autocmd BufRead,BufNewFile *.fdoc set filetype=yaml
" " md is markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown
" " automatically rebalance windows on vim resize
autocmd BufNewFile,BufRead Fastfile set filetype

autocmd VimResized * :wincmd =

let test#strategy = "dispatch"

" Fix issue with tmuxnavigator and tmp files
" https://github.com/christoomey/vim-tmux-navigator/issues/105
let $TMPDIR = $HOME."/tmp"

" Vim format mappings
let g:mix_format_on_save = 1
let g:mix_format_silent_errors = 1

let g:rainbow_active = 1 " Enable rainbow color globally

" Profile Vim by running this command once to start it and again to stop it.
function! s:profile(bang)
  if a:bang
    profile pause
    noautocmd qall
  else
    profile start /tmp/profile.log
    profile func *
    profile file *
  endif
endfunction

" increase max memory to show syntax highlighting for large files 
set maxmempattern=20000

" persistent vim history on disk
" Put plugins and dictionaries in this dir (also on Windows)
let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    let myUndoDir = expand(vimDir . '/undodir')
    " Create dirs
    call system('mkdir ' . vimDir)
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocompletion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" don't automatically show dictionary words for autocompletion " trigger with ctrlp
set complete+=kspell
set completeopt=menuone,longest "configure dictionary in english
set spelllang=en_us
set nospell
" Don't update status bar in autocompletion
set shortmess+=c
" Toggle spell check.
map <F6> :setlocal spell!<CR>

" Quickfix window {{{
function! ToggleQuickFix()
  if empty(filter(getwininfo(), 'v:val.quickfix'))
    copen
  else
    cclose
  endif
endfunction


" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" QuickScope
" Trigger a highlight in the appropriate direction when pressing these keys.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:qs_highlight_on_keys=['f', 'F', 't', 'T']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" delimitMate config for auto close quotes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:delimitMate_expand_cr = 1   
let g:delimitMate_expand_space = 1    
let g:delimitMate_smart_quotes = 1    
let g:delimitMate_expand_inside_quotes = 0    
let g:delimitMate_smart_matchpairs = '^\%(\w\|\$\)'   

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Completion + Snippet
" Ultisnips has native support for Supertab.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" loop forward in the results list
" let g:UltiSnipsExpandTrigger="<C-j>"
" let g:UltiSnipsJumpForwardTrigger="<tab>"  
" let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" ExpandSnippet: returns 1 if succeded 0 otherwise
let g:ulti_expand_res = 0 
function! ExpandSnippet()
  call UltiSnips#ExpandSnippet()
  return g:ulti_expand_res
endfunction
      \ }

" Add go special tab identitation
augroup filetypedetect
  autocmd FileType help wincmd L

  autocmd BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux
  autocmd BufNewFile,BufRead .nginx.conf*,nginx.conf* setf nginx
  autocmd BufNewFile,BufRead *.hcl setf conf

  autocmd BufRead,BufNewFile *.gotmpl set filetype=gotexttmpl

  autocmd BufNewFile,BufRead *.ino setlocal noet ts=4 sw=4 sts=4
  autocmd BufNewFile,BufRead *.txt setlocal noet ts=4 sw=4
  autocmd BufNewFile,BufRead *.md setlocal noet ts=4 sw=4
  autocmd BufNewFile,BufRead *.html setlocal noet ts=4 sw=4
  autocmd BufNewFile,BufRead *.vim setlocal expandtab shiftwidth=2 tabstop=2
  autocmd BufNewFile,BufRead *.hcl setlocal expandtab shiftwidth=2 tabstop=2
  autocmd BufNewFile,BufRead *.sh setlocal expandtab shiftwidth=2 tabstop=2
  autocmd BufNewFile,BufRead *.proto setlocal expandtab shiftwidth=2 tabstop=2

  autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4
  autocmd FileType yaml setlocal expandtab shiftwidth=2 tabstop=2
  autocmd FileType json setlocal expandtab shiftwidth=2 tabstop=2
  autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => YouCompleteME (autocompletion and and linter)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" disable all diagnostics so doesn't interfere with ALE
let g:ycm_show_diagnostics_ui = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ale (syntax checker and linter)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> <leader>n <Plug>(ale_next_wrap)

" we don't put gopls here as linter cause nvim already comes with one
" integrated that shows diagnostic errors as well
let g:ale_linters = { 'go': ['golangci-lint'], 'proto': ['protolint'], 'ruby': ['rubocop'], 'javascript': ['prettier'], 'vue': ['vim-vue'] }
let g:ale_fix_on_save = 1 " Enable ale fix on save
let g:ale_fixers = { 'go': ['golangci-lint'], 'proto': ['protolint'], 'javascript': ['prettier'], 'vue': ['eslint']  }
let g:ale_proto_protolint_config = "/Users/pabloa/.protolint.yml"
let g:ale_go_golangci_lint_package = 1
let g:ale_go_golangci_lint_options = '--disable-all -e composites -E goimports -E golint -E govet -E ineffassign -E rowserrcheck -E stylecheck'
let g:ale_enabled = 1
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart mappings on the command line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cno $c e <C-\>eCurrentFileDir("e")<cr>

" Unset paste on InsertLeave.
autocmd InsertLeave * silent! set nopaste

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Visual Multi
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:VM_maps = {}
let g:VM_maps["Add Cursor Down"]    = ',j'
let g:VM_maps["Add Cursor Up"]      = ',k'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Close the current buffer
map <leader>Bd :Bclose<cr>:tabclose<cr>gT

" Super useful when editing files in the same directory
map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/

func! CurrentFileDir(cmd)
  return a:cmd . " " . expand("%:p:h") . "/"
endfunc

command! -bang Profile call s:profile(<bang>0)

" show split window always at the very bottom of all other windows
:autocmd FileType qf wincmd J
