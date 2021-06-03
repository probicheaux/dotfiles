filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
set nowrap
set number
set nohlsearch
let mapleader = " "

call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'joshdick/onedark.vim'
Plug 'cocopon/iceberg.vim'
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'lambdalisue/gina.vim'
Plug 'universal-ctags/ctags'
Plug 'liuchengxu/vista.vim'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'LeafCage/yankround.vim'
Plug 'glidenote/memolist.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/rpc' }
Plug 'scrooloose/nerdtree'
Plug 'tsony-tsonev/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'mhinz/vim-startify'
Plug 'unblevable/quick-scope'
Plug 'liuchengxu/vim-which-key'
Plug 'justinmk/vim-sneak'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'jiangmiao/auto-pairs'
call plug#end()

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)

if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

let g:onedark_termcolors=256
let g:palenight_termcolors=256

"if (has("autocmd") && !has("gui_running"))
"  augroup colors
"    autocmd!
"    let s:background = { "gui": "#1E3440", "cterm": "235", "cterm16": "0" }
"    autocmd ColorScheme * call onedark#set_highlight("Normal", { "bg": s:background }) "No `fg` setting
"  augroup END
"endif
"onedark.vim override: Set a custom background color in the terminal
let g:airline_theme='onedark'
let g:fzf_preview_command = 'bat --color=always {-1}'
let g:fzf_preview_lines_command = 'bat --color=always --number'
syntax on
"colorscheme onedark
colorscheme palenight
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <leader>r <Plug>(coc-rename)
nmap <silent> <c-j> <Plug>(coc-diagnostic-prev)
nmap <silent> <c-k> <Plug>(coc-diagnostic-next)
let g:coc_prompt_win_width = 30

" Use K to show documentation in preview window
nnoremap <silent> <leader>k :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


autocmd CursorHold * silent call CocActionAsync('highlight')
nmap <F2> <Plug>(coc-rename)
xmap <leader>f  <Plug>(coc-format)
nmap <leader>f  <Plug>(coc-format)
command! -nargs=0 Format :call CocAction('format')

nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
if has('nvim')
  vnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<C-f>"
  vnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<C-b>"
endif

function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! ProjectFiles execute 'Files' s:find_git_root()

nnoremap <silent> <leader>l     :<C-u>FzfPreviewLines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'"<CR>

nnoremap <silent> <leader>p      :<C-u>FzfPreviewGitFilesRpc<CR>
nnoremap <silent> <leader>s :Startify<CR>

" Nerdtree
let g:NERDTreeGitStatusWithFlags = 1

let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 1

nmap <leader>n :NERDTreeToggle<CR>

nmap <leader>t :tabnew<CR>

" Quickscope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

highlight QuickScopePrimary guifg='#00C7DF' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#eF5F70' gui=underline ctermfg=81 cterm=underline
let g:qs_max_chars=150

" Sneak
let g:sneak#label = 1

" case insensitive sneak
let g:sneak#use_ic_scs = 1

" imediately move tot the next instance of search, if you move the cursor sneak is back to default behavior
let g:sneak#s_next = 1

" remap so I can use , and ; with f and t
map gS <Plug>Sneak_,
map gs <Plug>Sneak_;

" Change the colors
highlight Sneak guifg=black guibg=#00C7DF ctermfg=black ctermbg=cyan
highlight SneakScope guifg=red guibg=yellow ctermfg=red ctermbg=yellow

" Cool prompt
let g:sneak#prompt = '🔎 '
