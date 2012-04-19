"" pathogen.vim - vim plugin manager""""""""""""""""""""""""""""""
call pathogen#infect()
call pathogen#helptags()  " Generate the help tags for each bundle

"" Misc"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible      " Get out of VI's compatible mode
set showcmd           " Show unfinished command
set noswapfile
set nopaste           " Leave paste mode to enable some feature in vim, such as autocomplete
set nomodeline        " Turn off for security issues
set noswapfile
set lazyredraw        " Do not redraw while running macros (much faster)
set ttyfast           " Fast terminal

"" Encoding"""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8                                               " Use UTF-8 as default processing enc.
set fileencoding=utf-8                                           " File default encoding
set fileencodings=utf-8,big5,euc-jp,gbk,euc-kr,utf-bom,iso8859-1 " File encoding guess list
set termencoding=utf-8                                           " Terminal encoding
set ambiwidth=double                                             " Treat ambiguous width as double width (ONLY work for unicode encoding)
nnoremap ,b :e ++enc=big5<CR>:set tenc=big5<CR>

"" Fileformats""""""""""""""""""""""""""""""""""""""""""""""""""""
set fileformats=unix,dos,mac " Favorite file types, affect EOL format

"" FileType"""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin on " Enable file type plug-in
syntax on          " Enable syntax highlighting
autocmd! BufRead,BufNewFile *.conf set filetype=config
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType java setlocal omnifunc=javacomplete#Complete 

"" VIM UI"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set history=50        " keep 50 lines of command line history
set wildmenu          " Turn on wild menu
set showmatch         " Show matching braces
set backspace=2       " Allow backspacing over everything in insert mode, same as set backspace=indent,eol,start
set number            " Show line number
set showtabline=2     " Always show upper tab line
nnoremap <F2> :set number! number?<CR>

"" Font and Color""""""""""""""""""""""""""""
if has("gui_running")
    set gfn=DejaVu\ Sans\ Mono\ 14
    colorscheme darkblue
else
    set t_Co=256
    colorscheme xoria256
endif

"" Cursor line"""""""""""""""""""""""""""""""
autocmd InsertLeave * set cursorline
autocmd InsertEnter * set nocursorline

"" Status line"""""""""""""""""""""""""""""""
set laststatus=2
set statusline=%<%f%<%{FileTime()}%<%h%m%r%=%-20.(line=%03l,col=%02c%V,totlin=%L%)\%h%m%r%=%-30(,BfNm=%n%Y%)\%P\*%=%{CurTime()}
set ruler " Show current position in status line
set rulerformat=%15(%c%V\ %p%%%)
    
fun! FileTime()
    let ext = tolower(expand("%:e"))
    let fname = tolower(expand('%<'))
    let filename = fname . '.' . ext
    let msg = ""
    let msg = msg . " " . strftime("(Modified %b,%d %y %H:%M:%S)", getftime(filename))
    return msg
endf

fun! CurTime()
    let ftime = ""
    let ftime = ftime . " " . strftime("%b,%d %y %H:%M:%S")
    return ftime
endf

"" Search"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ignorecase " Ignore case when searching
set incsearch  " Incremental search
set hlsearch   " Highlight search things
set wrapscan   " Make search wrap around

"" Moving around and tabs"""""""""""""""""""""""""""""""""""""""""
nnoremap <LEADER>tc :tabnew<CR>
nnoremap <LEADER>te :tabedit<SPACE>
nnoremap <LEADER>tm :tabmove<SPACE>
nnoremap <LEADER>tk :tabclose<CR>
nnoremap <C-H> :tabprev<CR>
nnoremap <C-L> :tabnext<CR>

"" Text""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
set tabstop=4
set softtabstop=4
set shiftwidth=4                           " cident, >>, << width

"" Backup"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set backup
set backupdir=~/temp

"" Folding""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldenable         " Enable folding, I find it very useful
set foldmethod=syntax
set foldlevel=10000    " Set a high foldlevel to default open all folds
set foldcolumn=3       " 3 lines of column for fold showing, always
nnoremap <SPACE> za    " Easily open and close folds

"" Indent"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent " Auto indent
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class 
set wrap       " Wrap lines

""-------------------- plugin section --------------------------------
"" NeoComplCache
let g:neocomplcache_enable_at_startup = 1               " Use neocomplcache
let g:acp_enableAtStartup = 0                           " Disable AutoComplPop
let g:neocomplcache_enable_smart_case = 1               " Use smartcase
let g:neocomplcache_enable_camel_case_completion = 1    " Use camel case completion
let g:neocomplcache_enable_underbar_completion = 1      " Use underbar completion
let g:neocomplcache_min_syntax_length = 3

if !exists('g:neocomplcache_keyword_patterns')          " Define keyword.
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" <CR>: close popup and save indent
inoremap <expr><CR>  pumvisible() ? neocomplcache#smart_close_popup() : "\<CR>"
" <TAB>: completion
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"


"" NERD_tree.vim
nnoremap <F4> :NERDTreeToggle<CR>
let g:NERDTreeShowHidden = 1

"" Taglist
let Tlist_Sort_Type = "name"          " Sort by name
let Tlist_Use_Right_Window = 1        " Tlist window at the right side
nnoremap <F3> :TlistToggle<CR>
