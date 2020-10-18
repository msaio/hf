call plug#begin()

"SNIPPETS/AUTOCOMPLETE
Plug 'Valloric/YouCompleteMe'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'epilande/vim-react-snippets'

"NERDTREE/COMMENTER
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
"THEMES
"gruvbox
Plug 'morhetz/gruvbox'

""purify
"Plug 'kyoz/purify', { 'rtp': 'vim' }
""medic-chalk
"Plug 'ParamagicDev/vim-medic_chalk'
""dracula
"Plug 'dracula/vim', { 'as': 'dracula' }
""molokai
"Plug 'tomasr/molokai'
""jellybeans
"Plug 'nanotech/jellybeans.vim'
""wombat256i
"Plug 'dsolstad/vim-wombat256i'
""kolor
"Plug 'zeis/vim-kolor'
""solarized
"Plug 'altercation/vim-colors-solarized'
""onedark
"Plug 'joshdick/onedark.vim'
""papercolor
"Plug 'NLKNguyen/papercolor-theme'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"RESTORE SESSION => (PROBLEM WITH AUTOSAVE CONFIG BELOW)
Plug 'tpope/vim-obsession'

"Surroundings
Plug 'tpope/vim-surround'

"HMM
Plug 'guns/xterm-color-table.vim'

"Javascript
Plug 'pangloss/vim-javascript'
Plug 'briancollins/vim-jst'

call plug#end()

"fzf
set rtp+=~/.fzf
noremap <C-p> :FZF <CR>

"Snippet/Autocomplete
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_stop_completion = ['<Esc>']
let g:ycm_autoclose_preview_window_after_insertion = 1

"AIRLINE
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
set t_Co=256
let g:airline_theme='powerlineish'
"NERDTREE
"Nerdtree Toggle
map <F2> :NERDTreeToggle<CR>

"OPTIONAL
"CursorBind
noremap <F1> :set cursorbind! <CR>
"Save
noremap <F3> :w <Enter>
"Save all
noremap <F3><F3> :wall <Enter>
"Toggle PasteMode
set pastetoggle=<F27> "Ubuntu20.04
"set pastetoggle=<C-F3> "Ubuntu18.04
"Save and quit
noremap <F3><F4> :wq <Enter>
"Quit without saving
noremap <F4><F4> :q! <Enter>
"Save all openings and quit
noremap <F4><F3> :wqall! <Enter>
"Clear the highlight search
noremap <F29> :let @/ = "" <Enter>
"noremap <C-F5> :let @/ = "" <Enter>
"Get latest change
noremap <F5> :checktime <Enter>
"Buffer
noremap <F6><F6> :buffers <Enter>
noremap <F6> :buffer
"Obsession
noremap <F7> :Obsession <Enter>
noremap <F7><F7> :Obsession! <Enter>
"Mouse in vim
function! ToggleMouse()
	" check if mouse is enabled
	if &mouse == 'a'
		" disable mouse
		set mouse=
	else
		" enable mouse everywhere
		set mouse=a
	endif
endfunc
noremap <F31> :call ToggleMouse() <CR>
noremap <C-F7> :call ToggleMouse() <CR>

"Turn hybrid line numbers on
set nu rnu
set hls
set tabstop=2
set shiftwidth=2
set autoindent
set noswapfile

"new buffer on the right of the current buffer
set splitright
"new buffer below the current buffer
set splitbelow

"hmm
set cursorline
set cursorcolumn

"Auto save
"When text is changed (Problem with vim-ossesion)
autocmd TextChanged,TextChangedI <buffer> silent write
"When exiting insert mode and move to other panes
au InsertLeave,BufLeave * silent! wall

syntax on
"Treat .ejs files as html files
"au BufNewFile,BufRead *.ejs set filetype=html

"Add jbuilder syntax highlighting
au BufNewFile,BufRead *.json.jbuilder set ft=ruby

"Remember folding
augroup remember_folds
	autocmd!
	autocmd BufWinLeave * mkview
	autocmd BufWinEnter * silent! loadview
augroup END

""purify
"syntax on " This is required
"colorscheme purify
"set bg=light

""medic_chalk
"colorscheme medic_chalk
""set bg=light

""dracula
"colorscheme dracula
"highlight Normal ctermbg=NONE

""molokai
"colorscheme molokai

""jellybeans
"colorscheme jellybeans

""vim-wombat256i
"colorscheme wombat256i

""kolor
"colorscheme kolor
"highlight Normal ctermbg=NONE

""solarized
"syntax enable
"let g:solarized_termcolors=256
"let g:solarized_visibility='high'
"let g:solarized_contrast='high'
"set background=dark
"colorscheme solarized

""onedark
"syntax on
"colorscheme onedark
"highlight Normal ctermbg=NONE

""PaperColor
"set background=dark
"colorscheme PaperColor

"gruvbox
let g:gruvbox_contrast_dark='hard'
set bg=dark
silent colorscheme gruvbox
highlight Normal ctermbg=NONE

