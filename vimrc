" ====================================================================
" Author: D0n9X1n
" Email: D0n9x1n@outlook.com
" ReadMe: README.md
" Thanks: k-vim Project
" ====================================================================

" ====================================================================
" Initial Plugin
" ====================================================================

" Change <Leader> key
let mapleader = ','
let g:mapleader = ','

" Enable syntax highlighting
syntax on

" ====================================================================
" Add plugins to &runtimepath
" ====================================================================
call plug#begin('~/.vim/bundle')

" Main plugin configuration
if filereadable(expand("~/.vimrc.bundles"))
    source ~/.vimrc.bundles
endif

" Private overrides
if filereadable(expand("~/.vimrc.private"))
    source ~/.vimrc.private
endif

" Ensure filetype detection / plugins / indent rules are active
filetype plugin indent on

call plug#end()
" ====================================================================


" ====================================================================
" General Settings
" ====================================================================

" Simple auto-pairing for brackets and quotes
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {}<Esc>i
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=ClosePair('}')<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>

function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction

function QuoteDelim(char)
    let line = getline('.')
    let col = col('.')
    if line[col - 2] == "\\"
        " Escaped quote inside string
        return a:char
    elseif line[col - 1] == a:char
        " Move out of the string
        return "\<Right>"
    else
        " Start a quoted string
        return a:char.a:char."\<Esc>i"
    endif
endfunction

" Command history size
set history=1000

" Filetype detection / plugins / indentation
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on

" Auto-reload files changed outside Vim
set autoread

" Reduce startup messages
set shortmess=atI

" Backups & swap files
" set backup
" set backupext=.bak
" set backupdir=/tmp/vimbk/
set nobackup
set noswapfile

" Wildmenu ignore patterns
set wildignore=*.swp,*.bak,*.pyc,*.class,.svn,tags

" Highlight current line
" set cursorcolumn
set cursorline

" Keep screen contents after exit (useful for copy/paste from terminal)
set t_ti= t_te=

" Mouse settings
" set mouse=a          " enable mouse
set mouse-=a           " disable mouse (keyboard-centric)
set mousehide          " hide mouse cursor while typing

" Fix multi-cursor Ctrl-M interaction and selection behavior
set selection=inclusive
set selectmode=mouse,key

" Set terminal window title
set title

" Disable visual + audio bells
set novisualbell
set noerrorbells
set t_vb=
set tm=500

" Remember info about open buffers across sessions
set viminfo^=%

" Use 'magic' regex by default
set magic

" Backspace behaves predictably
set backspace=eol,start,indent
set whichwrap+=<,>,h,l


" ====================================================================
" Display Settings
" ====================================================================

" Show line/column in the status line
set ruler

" Show typed commands in the last line
set showcmd

" Show current mode
set showmode

" Keep cursor away from top/bottom edges
set scrolloff=15

" Custom statusline
set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P

" Always show status line
set laststatus=2

" Show absolute line numbers
set number

" Do not wrap long lines
set nowrap

" Highlight matching brackets
set showmatch
set matchtime=2  " tenths of a second

" Search behavior
set hlsearch      " highlight search results
" set incsearch   " incremental search (optional)
set ignorecase    " case-insensitive search...
set smartcase     " ...unless pattern contains uppercase

" Indentation settings
set smartindent
set autoindent

" Tabs and spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smarttab
set expandtab
set shiftround

" Allow hidden buffers
set hidden

" Command-line completion behavior
set wildmode=list:longest
set ttyfast

" Make <C-a>/<C-x> on numbers always treat them as decimal
set nrformats=

" Absolute line numbers by default (toggle function below can enable relative)
set norelativenumber number

" Toggle between absolute and relative line numbers
function! NumberToggle()
    if &relativenumber == 1
        set norelativenumber number
    else
        set relativenumber
    endif
endfunction

" Toggle background between dark/light
function! SetBGColor()
    if &background == 'dark'
        set background=light
        " colorscheme solarized
    else
        set background=dark
        " colorscheme gruvbox
    endif
endfunction

nnoremap <C-n> :call NumberToggle()<CR>


" ====================================================================
" FileEncode Settings
" ====================================================================

" Internal encoding
set encoding=utf-8

" Try these encodings when detecting files
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

" Help language (Chinese help docs)
set helplang=cn

" Terminal encoding
set termencoding=utf-8

" Use Unix as default file format
set ffs=unix,dos,mac

" Formatting options for multi-byte languages
set formatoptions+=m
set formatoptions+=B


" ====================================================================
" Others (misc)
" ====================================================================

" Make completion popup behave like IDEs
set completeopt=menu,menuone,longest

" Enhanced command-line completion
set wildmenu

" Ignore compiled files for completion / globbing
set wildignore=*.o,*~,*.pyc,*.class,tags

" Close preview window on leaving Insert mode
autocmd InsertLeave * if pumvisible() == 0 | pclose | endif

" Reopen file at last edit position (if possible)
if has("autocmd")
    au BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") |
                \   exe "normal! g'\"" |
                \ endif
endif


" ====================================================================
" HotKey Settings (Custom Mappings)
" ====================================================================

" Disable arrow keys in normal mode (later we reuse left/right for buffer nav)
map <Left>  <Nop>
map <Right> <Nop>
map <Up>    <Nop>
map <Down>  <Nop>

" Treat long lines as wrapped for j/k
nnoremap k  gk
nnoremap gk k
nnoremap j  gj
nnoremap gj j

" F1–F12 and useful <leader> mappings

" F1: disable default help
nnoremap <F1> <Esc>"

" Toggle background via <leader>b
nnoremap <leader>b :call SetBGColor()<CR>

" F2/F3: format code
nnoremap <F2> :Autoformat<CR>
nnoremap <F3> :Autoformat<CR>
nnoremap <leader>af :Autoformat<CR>

" F4: toggle line wrapping
nnoremap <F4> :set wrap! wrap?<CR>
nnoremap <leader>wr :set wrap! wrap?<CR>

" F5: quick run
nnoremap <F5> :QuickRun<CR>
nnoremap <leader>run :QuickRun<CR>

" F6: toggle relative number
nnoremap <F6> :call NumberToggle()<CR>
nnoremap <leader>rln :call NumberToggle()<CR>

" F7: toggle syntax highlighting (useful for large files)
nnoremap <F7> :exec exists('syntax_on') ? 'syn off' : 'syn on'<CR>
nnoremap <leader>syn :exec exists('syntax_on') ? 'syn off' : 'syn on'<CR>

" F8: toggle indent lines (IndentLine plugin)
nnoremap <F8> :IndentLinesToggle<CR>
nnoremap <leader>il :IndentLinesToggle<CR>

" F12: toggle gitgutter
nnoremap <F12> :GitGutterToggle<CR>
nnoremap <leader>git :GitGutterToggle<CR>

" F10: toggle line numbers
nnoremap <F10> :set number! number?<CR>
nnoremap <leader>ln :set number! number?<CR>

" Leave Insert mode -> always disable paste mode
au InsertLeave * set nopaste

" XTerm-style bracketed paste: auto-enable paste mode on paste
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ""
endfunction

" Window navigation (splits)
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Jump to start/end of line
noremap H ^
noremap L $

" Map ; to : for faster command entry
nnoremap ; :

" Command-line enhancements
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" Search mappings
map <space> /
" Use very magic regex by default
nnoremap / /\v
vnoremap / /\v

" Keep search result centered
nnoremap <silent> n  nzz
nnoremap <silent> N  Nzz
nnoremap <silent> *  *zz
nnoremap <silent> #  #zz
nnoremap <silent> g* g*zz

" Clear search highlight
noremap <silent><leader>/ :nohls<CR>

" Swap * and #
nnoremap # *
nnoremap * #

" Keep # in Python from jumping to column 0 on new lines
autocmd BufNewFile,BufRead *.py inoremap # X<c-h>#

" Buffer navigation
nnoremap [b :bprevious<CR>
nnoremap ]b :bnext<CR>
function! CloseBufferSmart()
    " If there's only one buffer left, just wipe it
    if len(getbufinfo({'buflisted':1})) == 1
        enew
        return
    endif

    " Try to go to an alternate buffer instead of closing window
    bnext | bdelete #
endfunction

noremap <left>  :bp<CR>
noremap <right> :bn<CR>
nnoremap <leader>q :call CloseBufferSmart()<CR>

" Toggle between current and last active tab
let g:last_active_tab = 1
nnoremap <silent> <leader>tt :execute 'tabnext ' . g:last_active_tab<CR>
autocmd TabLeave * let g:last_active_tab = tabpagenr()

" New tab with Ctrl+t
nnoremap <C-t> :tabnew<CR>
inoremap <C-t> <Esc>:tabnew<CR>

" Reselect after shifting indentation
vnoremap < <gv
vnoremap > >gv

" Make Y behave like other capital motions (to end of line)
map Y y$

" Select all
map <Leader>sa ggVG"

" Write file using sudo when needed
cmap w!! w !sudo tee >/dev/null %

" kj as <Esc> in insert mode
inoremap kj <Esc>

" Faster scrolling
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

" Fold current indent
nnoremap <leader>z za

" Force save with sudo
nnoremap <leader>w :w !sudo tee >/dev/null %<CR>

" Swap ' and ` to make jumps easier
nnoremap ' `
nnoremap ` '

" Remap U to redo
nnoremap U <C-r>

" ====================================================================
" FileType Settings
" ====================================================================

" Basic indent/style overrides
autocmd FileType cpp        set ts=2 sw=2 expandtab ai
autocmd FileType c          set ts=2 sw=2 expandtab ai
autocmd FileType javascript set ts=2 sw=2 expandtab ai
autocmd FileType java       set ts=2 sw=2 expandtab ai
autocmd FileType typescript setlocal formatprg=prettier\ --parser\ typescript

autocmd BufRead,BufNewFile *.md,*.mkd,*.markdown set filetype=markdown
autocmd BufRead,BufNewFile *.part                set filetype=html

" Strip trailing whitespace on save
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfunction
autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl
            \ autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" Highlight TODO / FIXME / NOTE / etc.
if has("autocmd")
    if v:version > 701
        autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|DONE\|XXX\|BUG\|HACK\)')
        autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\|NOTICE\)')
    endif
endif


" ====================================================================
" Theme Settings
" ====================================================================

if has('termguicolors')
    set termguicolors
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif


let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)

set background=dark

let g:gruvbox_contrast_dark='light'
colorscheme gruvbox

" GUI-specific settings
if has("gui_running")
    set guifont=FiraCode\ Nerd\ Font:h14.5
    colorscheme solarized8_flat
    if has("gui_gtk2")
        set guifont=FiraCode\ Nerd\ Font:h14.5
        colorscheme solarized8_flat
    endif
endif

" Match sign column background to line number column
hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange

" Softer spell-check highlights
highlight clear SpellBad
highlight SpellBad   term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap   term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare  term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline

" Remap left/right again here for buffer navigation (overrides earlier <Nop>)
noremap <left>  :bp<CR>
noremap <right> :bn<CR>

" Allow buffer modification
set modifiable

" C/C++: keep 'public' at column 0 (cinoptions tweak)
set cinoptions+=g0

" Highlight column 80
set cc=120

" Folding
set foldenable
set foldmethod=indent
set foldlevel=99

" Save and restore view (folds, cursor position etc.)
au BufWinLeave *.* silent mkview
au BufWinEnter *.* silent loadview

" Quick git push helper for OJ Game
map <leader>g :!git add . && git commit -am "%" && git pull origin master && git push origin master<CR>
