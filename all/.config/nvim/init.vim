call plug#begin()

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

Plug 'Konfekt/FastFold'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-css-color', {'for': ['css', 'scss']}
Plug 'christoomey/vim-tmux-navigator'
Plug 'dzeban/vim-log-syntax'
Plug 'file-line'
Plug 'freitass/todo.txt-vim'
Plug 'gmarik/sudo-gui.vim'
Plug 'henrik/vim-indexed-search'
Plug 'jiangmiao/auto-pairs'
Plug 'joonty/vdebug'
Plug 'jszakmeister/vim-togglecursor'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-peekaboo'
Plug 'ludovicchabant/vim-gutentags'
Plug 'machakann/vim-highlightedyank'
Plug 'majutsushi/tagbar'
Plug 'mbbill/undotree'
Plug 'neomake/neomake'
Plug 'rhysd/conflict-marker.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/confluencewiki.vim'

" Colors
Plug 'reedes/vim-colors-pencil'
Plug 'rakr/vim-two-firewatch'
Plug 'AlessandroYorba/Sierra'

call plug#end()

if (has("termguicolors"))
  set termguicolors
endif
let g:pencil_higher_contrast_ui=1
let g:pencil_gutter_color=1
let g:pencil_terminal_italics=1
colorscheme pencil
nnoremap <silent> <leader>d :set bg=dark<cr>
nnoremap <silent> <leader>l :set bg=light<cr>

" these plugins are bundled in $VIMRUNTIME
runtime macros/matchit.vim

" basic editor config
set hidden number relativenumber
set expandtab tabstop=2 shiftwidth=2
set smartindent
set autoread
set showmatch
set ignorecase smartcase
set scrolloff=2
set whichwrap+=<,>,[,]
set nobackup noswapfile
set mousemodel=popup_setpos
set shortmess=atI
set clipboard+=unnamedplus
set undofile
set undodir=~/.vimundo
set colorcolumn=81
set inccommand=nosplit

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" goyo
nnoremap <leader><space> :Goyo<cr>

" tagbar
nnoremap <leader>t :TagbarToggle<cr>

" vdebug
if !exists('g:vdebug_options')
  let g:vdebug_options = {}
endif
if !exists('g:vdebug_options.path_maps')
  let g:vdebug_options.path_maps = {}
endif
let g:vdebug_options["break_on_open"] = 0

" undotree
nnoremap <leader>u :UndotreeToggle\|UndotreeFocus<CR>
nnoremap U <c-r>

" gitgutter
let g:gitgutter_sign_column_always = 1
let g:gitgutter_sign_modified = '±'
let g:gitgutter_sign_modified_removed = '±'
let g:gitgutter_sign_removed = '-'

" easyalign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" neomake
autocmd! BufWritePost,BufEnter * silent Neomake
autocmd! InsertLeave,TextChanged,FocusLost * silent! update|Neomake

let g:neomake_vim_enabled_makers = ['vimlint']
let g:neomake_javascript_enabled_makers = ['semistandard']

" airline
let g:airline_theme='pencil'
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols={}
endif
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#fnamecollapse=0
let g:airline#extensions#tabline#fnametruncate=0
let g:airline#extensions#tabline#buffer_nr_show = 1

" quickly edit/reload the vimrc file
nnoremap <silent> <leader>ev :edit $MYVIMRC<CR>
augroup sourcevimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC nested silent source $MYVIMRC
augroup end

" clear search highlight
nnoremap <leader>/ :noh<CR><ESC>

" The following two options interfere with one another.
"
" To display tabs and trailing space use :set list
" for word wrapping use :set nolist
nnoremap <silent> <leader>w :set list!<cr>

" word wrapping
set lbr formatoptions=l

" highlight whitespace
set list listchars=tab:⇥\ ,trail:·

" drupal stuff
autocmd BufRead,BufNewFile *.module set filetype=php
autocmd BufRead,BufNewFile *.install set filetype=php
autocmd BufRead,BufNewFile *.info set filetype=dosini

" good enough folding for bracey languages
autocmd FileType css,scss,less,javascript setlocal foldmethod=marker
autocmd FileType css,scss,less,javascript setlocal foldmarker={,}
autocmd FileType css,scss,less,javascript normal zR

" nice folding
set foldlevel=99
set fillchars="fold: "
set foldtext=MyFoldText()
function! MyFoldText()
  let line = getline(v:foldstart)
  if match(line, "/\*\\*") == -1
    " not a docblock
    return line . " …"
  else
    " docblock - is it @file?
    let firstLine = getline(v:foldstart + 1)
    let secondLine = getline(v:foldstart + 2)
    let description = (match(firstLine, "@file") == -1) ? firstLine : secondLine
    return line . substitute(description, "^\\s*\\*", "", "") . " */"
  end
endfunction

" make space toggle folds
noremap <Space> za

" fzf
let $FZF_DEFAULT_COMMAND='ag --hidden --ignore=.git -g ""'
map <silent> <C-p> :FZF<cr>
map <silent> <C-t> :Tags<cr>
map <silent> <C-r> :BTags<cr>
map <silent> <C-f> :Ag<cr>
map <silent> <C-b> :Buffers<cr>

" syntax folding for php
let php_folding=2
let php_phpdoc_folding=1
nnoremap <leader>f :set foldlevel=0<cr>

" highlight php docblocks
function! PhpSyntaxOverride()
  hi! def link phpDocTags phpDefine
  hi! def link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
  autocmd!
  autocmd FileType php call PhpSyntaxOverride()
augroup END

" auto-pairs
" Interferes with markdown checkboxes.
let g:AutoPairsMapSpace = 0

" Tab to switch buffers
nnoremap <tab> <c-^>

" deoplete
let g:deoplete#enable_at_startup = 1
inoremap <expr> <S-Tab>  pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
