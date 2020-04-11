call plug#begin()

"SNIPPETS/AUTOCOMPLETE
Plug 'Valloric/YouCompleteMe'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
"NERDTREE/COMMENTER
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
"THEMES
Plug 'rafi/awesome-vim-colorschemes'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"RESTORE SESSION
Plug 'tpope/vim-obsession'

call plug#end()

"Snippet/Autocomplete
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_stop_completion = ['<Esc>']

"AIRLINE
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
set t_Co=256
let g:airline_theme='powerlineish'
"NERDTREE
"Nerdtree Toggle
map <F2> :NERDTreeToggle<CR>

"OPTIONAL
"Save
noremap <F3><F3> :w <Enter>
"Save and quit
noremap <F3><F4> :wq <Enter>
"Quit without saving
noremap <F4><F4> :q! <Enter>
"Save all openings and quit
noremap <F4><F3> :wqall! <Enter>
"Clear the highlight search
noremap <F5> :let @/ = "" <Enter>
"Buffer
noremap <F6><F6> :buffers <Enter>
noremap <F6> :buffer
"Obsession
noremap <F7> :Obsession <Enter>
noremap <F7><F7> :Obsession! <Enter>

"set nu
"Turn hybrid line numbers on
set nu rnu
set hls
set tabstop=2
set shiftwidth=2
set autoindent
colorscheme purify
set noswapfile

"Auto save whenever text is 1changed
autocmd TextChanged,TextChangedI <buffer> silent write
