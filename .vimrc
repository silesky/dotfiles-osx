let g:mapleader = " "
if has('unix')
  "linux STUFF
endif
if has('macunix')
endif
""""""""""""""""""""""""""""""""""""""""
" Fonts
if has('win32')
  set guifont=Consolas:h12   " Win32.
elseif has('gui_macvim')
  set guifont=Monaco:h14     " OSX.
else
  set guifont=Monaco     " OSX.
endif
" other fonts = Fira\ Mono
"""""""""""""""""""""""""""""""""""


""""""VIM PLUG""""""""""""""""""""""""
if empty(glob("~/.vim/autoload/plug.vim"))
  execute '!mkdir -p ~/.vim/ ~/.vim/autoload ~/.vim/bundle'
  execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif
call plug#begin('~/.vim/plugged')
" YOUR LIST OF PLUGINS GOES HERE LIKE THIS:
  if v:version >=800
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
  endif
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-unimpaired' "quickfix ]a and [b and move down and up is [e ]e
  Plug 'mxw/vim-jsx'
  Plug 'slashmili/alchemist.vim'
  Plug 'elixir-lang/vim-elixir'
  Plug 'zyedidia/literate.vim'
  Plug 'cakebaker/scss-syntax.vim'
  Plug 'tpope/vim-repeat' "let's you use the dot command with vim surround
  Plug 'tpope/vim-surround' "cst
  Plug 'avakhov/vim-yaml'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'leafgarland/typescript-vim'
  Plug 'pangloss/vim-javascript' "syntax hl
  Plug 'gregsexton/gitv'
  Plug 'tpope/vim-fugitive'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'tpope/vim-sleuth'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'haya14busa/incsearch.vim'
  " colorschemes
  Plug 'flazz/vim-colorschemes'
  Plug 'jacoborus/tender.vim' "sort of like firwatch but works with mvim
  Plug 'hhsnopek/vim-firewatch' "doesn't work with mvim
  Plug 'dikiaap/minimalist'
  Plug 'lifepillar/vim-solarized8'
  Plug 'trevordmiller/nova-vim'
  Plug 'wincent/terminus'
  Plug 'machakann/vim-highlightedyank'
  "
  "detect indent
  " sudo npm -g install instant-markdown-d
  Plug 'scrooloose/nerdtree'
  Plug 'suan/vim-instant-markdown'
  Plug 'epmatsw/ag.vim'
  Plug 'gcorne/vim-sass-lint'
  Plug 'luochen1990/rainbow'
  let g:rainbow_active = 1 " rainbow matching braces

  Plug 'sjl/vitality.vim' "make vim play nicely with iterm and tmux
  Plug 'tpope/vim-eunuch' "\:MOVE etc
  Plug 'terryma/vim-expand-region'

" iTerm: fix extra [200] chars when pasting
set t_BE=

"" changes the cursor shape/color
" in the terminal depending on the mode
" see http://code.google.com/p/iterm2/issues/detail?id=710&q=cursor
function! SetCursorStyle()
  if &term =~ "xterm\\|rxvt"
    " use a | cursor in insert mode
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"

    " use a rectangle cursor otherwise
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"

    " reset cursor when vim exits
    autocmd VimLeave * silent !echo -ne "\<Esc>]50;CursorShape=0\x7"

  endif
endfunction
" COLORSCHEME
" Completor: Postinstall hook (for versions over 8, install this, otherwise install ycm)
function! BuildCompletor(info)
  if a:info.status == 'installed' || 'updated' || a:info.force
    !make js
  endif
endfunction

if v:version >= 800 && !exists('g:vscode')
  Plug 'maralla/completor.vim', { 'do': function('BuildCompletor') }
endif



call plug#end()
" DIRECTIONS:
" for airline:
set laststatus=2
"allows you to use left or right to nav through completion:
set wildmenu
set wildmode=longest:full,full
syntax enable
set encoding=utf-8
"
" get html indenting working
let g:html_indent_inctags = "html,body,head,tbody"
filetype indent on " html auto indent working
filetype plugin indent on
" o goes down and then matches the indentation of the prev line
set autoindent

nnoremap <F8> gg=G``:echoerr 'Auto indented.'<CR>

" edit vimrc in pane below
nnoremap <leader>erc :sp<CR>:e $MYVIMRC<CR>

" reload vimrc
nnoremap <leader>rrc :so $myvimrc<cr>:echoerr '$myvimrc reloaded.'<cr>:noh<cr>


" show highlighting after yank
if !exists('##TextYankPost')
  map y <Plug>(highlightedyank)
endif

set hlsearch " search highlighting.
set ignorecase " ignore case when i search by default
set smartcase " goes with ignorecase... It means that unless there is uppercase on the string, it's case insensive by default
set incsearch " see searc results as I type them in
set history=1000 "remember more commands
set hidden "doesn't forget marks between buffers
" firewatch tender Monokai gotham zenburn 256_noir 256_grayvim
set t_Co=256 "otherwise you'll only see  8bits

if has("gui_running")
  " set 24-bit colors. to check if your terminal supports it,
  " do printf '\x1b[38;2;255;100;0mTRUECOLOR\x1b[0m\n' ... TRUECOLORS should
  " be in red
  set termguicolors
endif

function! SetSolarized()
  colorscheme solarized8_dark_high
endfunction
" call SetSolarized()
set bg=dark
colorscheme zenburn
"hi Normal ctermbg=002b36 "firewatch needs this extra
hi Search cterm=NONE ctermfg=black ctermbg=yellow
hi Visual cterm=NONE ctermfg=white ctermbg=red guibg=red "search highlighting

" line numbers
set nu

"Keep 8 lines above or below the cursor when scroling or searching (offset)
set scrolloff=8

"wrap lines by default
"https://github.com/sheerun/vimrc
set wrap linebreak
set showbreak=" "

"common mistake of q: instead of :q
map q: :q

map <leader>= mzgg=G`z
" double escape to save
map <leader><leader> :w<CR>
" mouse for scrolling and window resizing
set mouse=a
set clipboard=unnamed
set backspace=indent,eol,start
set backupcopy=yes
set noswapfile " no swap file


" make bracket matching color have better contrast
" :highlight MatchParen ctermbg=black guibg=black
" Enable CursorLine
set cursorline
" Default Colors for CursorLine
" highlight  CursorLine ctermbg=Yellow ctermfg=None

" copy visually selected text to search
vnoremap / y/<C-R>"

set tabstop=2 " The width of a TAB is set to a [number]
" Still it is a \t. It is just that
" Vim will interpret it to be having
" a width of 4.
set shiftwidth=2    " Indents will have a width of [number]
set softtabstop=2   " Sets the number of columns for a TAB
set expandtab     " Expand TABs to spaces
set smarttab      " Enabling this will make the tab key (in insert mode) insert spaces or tabs to
"go to the next indent of the next tabstop when the cursor is at the beginning
"of a line (ie: the only preceding characters are whitespace)

" remove escape delay
set timeoutlen=1000 ttimeoutlen=0
" ale uses timers which only work om vim 8
if v:version >= 800
  " let g:ale_set_quickfix = 1 " makes grep quickfix buggy
  augroup FiletypeGroup
    autocmd!
    au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
  augroup END
endif

" wrap toggle
function! ToggleWrap()
  if (&wrap == 1)
    set nowrap
  else
    set wrap
  endif
endfunction
map <leader>w :call ToggleWrap()<CR>

" get rid of trailing whitespace
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
" set tab
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype scss setlocal ts=4 sw=4 expandtab
autocmd Filetype javascript setlocal ts=4 sw=4 sts=0 noexpandtab
" set custom filetype
au BufRead,BufNewFile *.eslintrc setfiletype javascript
au BufRead,BufNewFile *.json setfiletype javascript

"vimdiff loafs another theme
" http://stackoverflow.com/questions/2019281/load-different-colorscheme-when-using-vimdiff
if &diff
  colorscheme Monokai
endif
"reload
noremap <F12> :e!<CR>

" rebind arrow keys to do nothing
noremap <Right> :echo "no right for you!"<CR>
noremap <Down> :echo "No Down for you!"<CR>
noremap <Up> :echo "No Up for you!"<CR>
noremap <Left> :echo "No Left for you!"<CR>
""""""""""""""""""""""""
" CTRLP
" Ignore some folders and files for CtrlP indexing
let g:ctrlp_custom_ignore = {
      \ 'dir':  '\.git$\|\upload[sS]$|\.yardoc\|public$|log\|tmp$\|node_modules$\|modules$',
      \ 'file': '\.so$\|\.dat$|\.DS_Store$|\.jpg$|\.gif$'
      \ }
set runtimepath^=~/.cim/bundle/ctrlp.vim  "http://ctrlpvim.github.io/ctrlp.vim/#installation
let g:ctrlp_map='<c-p>'

" let g:ctrlp_cmd = 'CtrlPMRU'
" don't limit the ctrlp results
let g:ctrlp_match_window = 'min:4,max:25'
" let g:ctrlp_cmd = 'CtrlPMixed' "to switch between recent, file etc, ctrl-f/b
let g:ctrlp_cmd = 'call CallCtrlP()'
func! CallCtrlP()
  if exists('s:called_ctrlp')
    CtrlPLastMode
  else
    let s:called_ctrlp = 1
    CtrlPMRU
  endif
endfunc
"""""""""""""""""""""""""""
" JSBEAUTIFY
map <F4> :call JsBeautify()<cr>
" or
autocmd FileType javascript noremap <buffer>  <F4> :call JsBeautify()<cr>
" for json
autocmd FileType json noremap <buffer> <F4> :call JsonBeautify()<cr>
" for jsx
autocmd FileType jsx noremap <buffer> <F4> :call JsxBeautify()<cr>
" for html
autocmd FileType html noremap <buffer> <F4> :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <buffer> <F4> :call CSSBeautify()<cr>
"""""""""""""""""""""""""""
" Instant Markdown
" https://github.com/suan/vim-instant-markdown
let g:instant_markdown_autostart = 0
noremap <silent> <leader>md :InstantMarkdownPreview<CR>

set pastetoggle=<leader>p


let g:jsx_ext_required = 0
""""""""""""""""""""""""
" theme explorer
" let g:netrw_banner = 0
" let g:netrw_liststyle = 3
" let g:netrw_browse_split = 4
" let g:netrw_altv = 1
" let g:netrw_winsize = 25
""""""""""""""""""""""""
noremap !! :set shellcmdflag=-ic<CR>
""""""""""""""""""""""""""""""""""
" auto watch changes to file without any prompt
set autoread
"might be osx only
au CursorHold * checktime
"==========================
"  copy / yank all
" nnoremap <C-S-y> :%y<CR>
"--------------------------
"==========================
" The Silver Searcher
if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
" ==================================================
:set wrapscan "toggle arround search
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
let g:incsearch#auto_nohlsearch = 1 "don't show automatically
map ?? :noh<CR>
:vmap * y:let @/ = @"<CR>
" hit v to expand one word, v again to expand a paragraph
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

"" use leader+q to toggle quickfix
function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
    echohl ErrorMsg
    echo "Location List is Empty."
    return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction
nmap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
nmap <silent> <leader>q :call ToggleList("Quickfix List", 'c')<CR>

autocmd FileType javascript set formatprg=prettier-eslint\ --stdin

if !exists('g:vscode')
  let g:NERDTreeQuitOnOpen=0 "don't close sidebar when opening a file
endif
" when I vim to a new file, change the working directory as well (you can
" check in nerdtree
set autochdir
" auto-reload vimrc
augroup reload_vimrc " {
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" show list of buffers and prepend space
nnoremap <leader>B :ls<CR>:b<Space>
noremap <silent> <leader>b :NERDTreeToggle<CR>
inoremap jj <ESC>

" rebind arrow keys to something useful
nmap <Left> <<
nmap <Right> >>
vmap <Left> <gv
vmap <Right> >gv

nmap <Up> [e
nmap <Down> ]e
vmap <Up> [egv
vmap <Down> ]egv

