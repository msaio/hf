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
"set pastetoggle=<F27> "Ubuntu20.04
set pastetoggle=<C-F3> "Ubuntu18.04
"Save and quit
noremap <F3><F4> :wq <Enter>
"Quit without saving
noremap <F4><F4> :q! <Enter>
"Save all openings and quit
noremap <F4><F3> :wqall! <Enter>
"Clear the highlight search
"noremap <F29> :let @/ = "" <Enter>
noremap <C-F5> :let @/ = "" <Enter>
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
