"PlugInstall
call plug#begin('~/.vim/plugged')
Plug 'vim-scripts/copypath.vim'
Plug 'vim-scripts/RltvNmbr.vim'
Plug 'Houl/repmo-vim'
Plug 'tpope/vim-fugitive'
Plug 'shumphrey/fugitive-gitlab.vim' "for Gbrowse
Plug 'fatih/molokai'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'muhitsarwar/vim-bookmarks', { 'branch': 'muhit/feature/toogle-between-stack-and-normal-mode' }
Plug 'christoomey/vim-tmux-navigator'
Plug 'dhruvasagar/vim-zoom'
Plug '907th/vim-auto-save'
Plug 'michaeljsmith/vim-indent-object'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"language specific
Plug 'google/vim-jsonnet'
Plug 'fatih/vim-go'
Plug 'prabirshrestha/vim-lsp' 
Plug 'mattn/vim-lsp-settings' "LspInstallServer to install server
Plug 'udalov/kotlin-vim'
call plug#end()




"mouse scroll and enable
set mouse=a
if !has('nvim')
  set ttymouse=xterm2
endif
"set ttyfast
"if !has('nvim')
"  set ttymouse=xterm2
"  set ttyscroll=3
"endif
"set mouse=a                     "Enable mouse mode

" Show whitespace
set list
set listchars=tab:--


set laststatus=2
set encoding=utf-8              " Set default encoding to UTF-8
set autoread                    " Automatically reread changed files without asking me anything
set autoindent                  
set backspace=indent,eol,start  " Makes backspace key more powerful.
set incsearch                   " Shows the match while typing
set hlsearch                    " Highlight found searches

set noerrorbells             " No beeps
set number                   " Show line numbers
set showcmd                  " Show me what I'm typing
set noswapfile               " Don't use swapfile
set nobackup                 " Don't create annoying backup files
set splitright               " Split vertical windows right to the current windows
set splitbelow               " Split horizontal windows below to the current windows
set autowrite                " Automatically save before :next, :make etc.
set hidden
set fileformats=unix,dos,mac " Prefer Unix over Windows over OS 9 formats
set noshowmatch              " Do not show matching brackets by flickering
set noshowmode               " We show the mode with airline or lightline
set ignorecase               " Search case insensitive...
set smartcase                " ... but not it begins with upper case 
set completeopt=menu,menuone
set nocursorcolumn           " speed up syntax highlighting
set nocursorline
set updatetime=300
set pumheight=10             " Completion window max size
set conceallevel=2           " Concealed text is completely hidden

set shortmess+=c   " Shut off completion messages
set belloff+=ctrlg " If Vim beeps during completion

set lazyredraw

"http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
set clipboard^=unnamed
set clipboard^=unnamedplus

" increase max memory to show syntax highlighting for large files 
set maxmempattern=20000

" ~/.viminfo needs to be writable and readable. Set oldfiles to 1000 last
" recently opened files, :FzfHistory uses it
set viminfo='1000

" color
syntax enable
set t_Co=256
set background=dark
let g:molokai_original = 1
let g:rehash256 = 1
colorscheme molokai



"=====================================================
"===================== STATUSLINE ====================

let s:modes = {
      \ 'n': 'NORMAL', 
      \ 'i': 'INSERT', 
      \ 'R': 'REPLACE', 
      \ 'v': 'VISUAL', 
      \ 'V': 'V-LINE', 
      \ "\<C-v>": 'V-BLOCK',
      \ 'c': 'COMMAND',
      \ 's': 'SELECT', 
      \ 'S': 'S-LINE', 
      \ "\<C-s>": 'S-BLOCK', 
      \ 't': 'TERMINAL'
      \}

let s:prev_mode = ""
function! StatusLineMode()
  let cur_mode = get(s:modes, mode(), '')

  " do not update higlight if the mode is the same
  if cur_mode == s:prev_mode
    return cur_mode
  endif

  if cur_mode == "NORMAL"
    exe 'hi! StatusLine ctermfg=236'
    exe 'hi! myModeColor cterm=bold ctermbg=148 ctermfg=22'
  elseif cur_mode == "INSERT"
    exe 'hi! myModeColor cterm=bold ctermbg=23 ctermfg=231'
  elseif cur_mode == "VISUAL" || cur_mode == "V-LINE" || cur_mode == "V_BLOCK"
    exe 'hi! StatusLine ctermfg=236'
    exe 'hi! myModeColor cterm=bold ctermbg=208 ctermfg=88'
  endif

  let s:prev_mode = cur_mode
  return cur_mode
endfunction

function! StatusLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! StatusLinePercent()
  return (100 * line('.') / line('$')) . '%'
endfunction

function! StatusLineLeftInfo()
 let branch = fugitive#head()
 let filename = '' != expand('%:F') ? expand('%:F') : '[No Name]'
 if branch !=# ''
   return printf("%s | %s", branch, filename)
 endif
 return filename
endfunction

exe 'hi! myInfoColor ctermbg=240 ctermfg=252'

" start building our statusline
set statusline=

" mode with custom colors
set statusline+=%#myModeColor#
set statusline+=%{StatusLineMode()}               
set statusline+=%*

" left information bar (after mode)
set statusline+=%#myInfoColor#
set statusline+=\ %{StatusLineLeftInfo()}
set statusline+=\ %*

" go command status (requires vim-go)
set statusline+=%#goStatuslineColor#
set statusline+=%{go#statusline#Show()}
set statusline+=%*

" right section seperator
set statusline+=%=

" filetype, percentage, line number and column number
set statusline+=%#myInfoColor#
set statusline+=\ %{StatusLineFiletype()}\ %{StatusLinePercent()}\ %l:%v
set statusline+=\ %*

" set cursor like vince
set cursorcolumn
set cursorline

"cusomized nerdtree
map <C-g> :NERDTreeToggle<CR>
map <C-f> :NERDTreeFind<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif "close vim if the only window left open is a NERDTree

"wraping text
set nowrap

"repeat motion https://github.com/Houl/repmo-vim
" map a motion and its reverse motion:
:noremap <expr> h repmo#SelfKey('h', 'l')|sunmap h
:noremap <expr> l repmo#SelfKey('l', 'h')|sunmap l
" if you like `:noremap j gj', you can keep that:
:map <expr> j repmo#Key('gj', 'gk')|sunmap j
:map <expr> k repmo#Key('gk', 'gj')|sunmap k
" repeat the last [count]motion or the last zap-key:
:map <expr> ; repmo#LastKey(';')|sunmap ;
:map <expr> , repmo#LastRevKey(',')|sunmap ,
:noremap <expr> f repmo#ZapKey('f')|sunmap f
:noremap <expr> F repmo#ZapKey('F')|sunmap F
:noremap <expr> t repmo#ZapKey('t')|sunmap t
:noremap <expr> T repmo#ZapKey('T')|sunmap T


"vim-go related
nnoremap gv :vsp<CR>:GoDef<CR>


" Better split switching
"map <C-j> <C-W>j
"map <C-k> <C-W>k
"map <C-h> <C-W>h
"map <C-l> <C-W>l


"Use the black hole register, _ to really delete something: "_d.
nnoremap d "_d
vnoremap d "_d

"plz don't commit it until u store bookmark in stack
"bookmark config
let g:bookmark_auto_close=1
let g:bm_stack_mode=1

"move line up or down
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

"move selected block left and right and keep selected
vnoremap < <gv
vnoremap > >gv

"yank without existting ode
vnoremap y ygv
"yank full line
nnoremap Y yy

"nwe line without exitting normal mode
nnoremap o o<Esc>

"grep shortcut
nnoremap gr :Ggrep <cword><CR>:copen<CR><CR>

"vim auto save session
"fu! SaveSess()
"    execute 'mksession! ' . getcwd() . '/.session.vim'
"endfunction

"fu! RestoreSess()
"if filereadable(getcwd() . '/.session.vim')
"    execute 'so ' . getcwd() . '/.session.vim'
"    if bufexists(1)
"        for l in range(1, bufnr('$'))
"            if bufwinnr(l) == -1
"                exec 'sbuffer ' . l
"            endif
"        endfor
"    endif
"endif
"endfunction

"autocmd VimLeave * NERDTreeClose
"autocmd VimLeave * call SaveSess()

"autocmd VimEnter * nested call RestoreSess()

"ctrlp related
"fzf and vim
noremap <C-p> :Files<CR>

"json quote
set conceallevel=0

"zoom
nmap zm <C-W>m
"set statusline+=%{zoom#statusline()}

"auto save
"let g:auto_save = 1

"open current file in jetbrains
"nnoremap gl :!goland ~/Go\ project/seapay100_module/%<CR><CR> 
"you need you configure goland/pycharm. plz check https://www.jetbrains.com/help/go/working-with-the-ide-features-from-command-line.html#toolbox
"nnoremap op :!code %<CR><CR>



"goto next indent line
"nnoremap <C-k> :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%<' . line('.') . 'l\S', 'be')<CR>
"nnoremap <C-j> :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%>' . line('.') . 'l\S', 'e')<CR>

"relative number
set number                     " Show current line number
set relativenumber             " Show relative line numbers
highlight LineNr ctermfg=green
"autocmd VimEnter,BufEnter * RltvNmbr
"autocmd :RltvNmbr



"%% for same directory https://vonheikemen.github.io/devlog/tools/vim-and-the-quickfix-list/
cnoremap <expr> %% getcmdtype() ==# ':' ? fnameescape(expand('%:h')) . '/' : '%%'

"quickfix: 
function! QuickfixMapping()
  " Go to the previous location and stay in the quickfix window
  nnoremap <buffer> k :cprev<CR><C-w>w
  " Go to the next location and stay in the quickfix window
  nnoremap <buffer> j :cnext<CR><C-w>w
endfunction
augroup quickfix_group
    autocmd!
    autocmd filetype qf call QuickfixMapping()
augroup END

"cursor always center
augroup VCenterCursor
  au!
  au BufEnter,WinEnter,WinNew,VimResized *,*.*
        \ let &scrolloff=winheight(win_getid())/2
augroup END"
"if want to disable above feature
"au! VCenterCursor
"

"set tab or space indent
set noet sw=4 ts=4 "et=expandtab sw=shiftwidth ts=tabstop
"set et sw=2 "set 2 space as indent
