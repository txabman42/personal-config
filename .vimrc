" configure Vundle
filetype on " without this vim emits a zero exit status, later, because of :ft off
" filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
source ~/.vim/config/.vimrc.bundles.colors
source ~/.vim/config/.vimrc.bundles.lenguages
source ~/.vim/config/.vimrc.bundles.utils
source ~/.vim/config/.vimrc.bundles.vim
call vundle#end()

" Fix cursor in TMUX
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

if filereadable(expand("~/.vimrc.local"))
  source ~/.vim/config/.vimrc.colors
  source ~/.vim/config/.vimrc.lenguages
  source ~/.vim/config/.vimrc.utils
  source ~/.vim/config/.vimrc.vim
endif
