let g:javascript_plugin_jsdoc = 1
execute pathogen#infect()

" Syntax and highlighting
syntax on
filetype on

" What is the difference between the following two lines?
au BufRead,BufNewFile *.json set filetype=javascript
au BufRead,BufNewFile *.abnf setfiletype abnf
au! Syntax json source ~/.vim/bundle/json.vim

let g:syntastic_json_checkers=['jsonlint']

let g:syntastic_javascript_checkers = ['eslint']
let g:javascript_enable_domhtmlcss = 1

let g:syntastic_html_tidy_ignore_errors = [
	\  '<a> attribute "href" lacks value',
	\  'trimming empty <span>',
	\  'trimming empty <h1>'
	\ ]

let g:syntastic_always_populate_loc_list = 1

" Hides the intro message:
set shortmess+=I

" Plugins
map <C-n> :NERDTreeToggle<CR>
let NERDTreeChDirMode=2

" Appearance
colorscheme molokai
let g:rehash256 = 1
set t_Co=256

" Invoking `set number` first allows us to see the absolute line number for
" the current line, and relative numbers for every other line.
set number
set relativenumber
set cursorline
set hlsearch
set incsearch

set textwidth=80
" Prevents newline insertion at text width threshold:
set formatoptions-=t

" Are you ready to ROC? (This enables easier JSDoc-style comments)
set formatoptions+=roc

" Highlight the preferred 80-column range:
set colorcolumn=+1
let &colorcolumn=join(range(81,999),",")
highlight ColorColumn ctermbg=235 guibg=#2c2d27

" Overwrite the default visual mode highlight colors:
" Orangish yellow (#FFAF00):
hi! Visual ctermbg=214
" Black (#000000):
hi! Visual ctermfg=016

set nowrap
set guifont=Monaco:h18

map <A> :

" Behavior
set smartindent
set noexpandtab
set tabstop=4
set shiftwidth=4
set listchars=trail:~
set scrolloff=5
set backspace=indent,eol,start

autocmd BufWritePre * :%s/\s\+$//e
autocmd BufEnter * silent! lcd %:p:h

autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

au StdinReadPost * :set nomodified

map <C-t> <ESC>:tabnew<CR>
map <C-l> <ESC>:tabnext<CR>
map <C-h> <ESC>:tabprev<CR>
map <C-e> <c-w>gf

map <C-q> <ESC>:q<CR>

map <C-a> <ESC>:lprev<CR>
map <C-s> <ESC>:lnext<CR>

map <space> i <esc>r
map <C-k> :set invpaste<CR>

map <C-x> :noh<CR>

let NERDTreeChDirMode=2
let NERDTreeShowHidden=1

" This is a function for running git grep on a word or phrase.
" To use this, copy the following three lines (uncommented) to your .vimrc.
"
" 	* The first line sources this file.
" 	* The second line sets up a keybinding to grep for the current word
" 	  when the keybinding is activated.
" 	* The third line sets up a command, so that you can type ':F something'
"	  in normal mode, and the command will execute.
"
" (NOTE: You may want to bind to something other than CTRL + F; it's up to you.)

" source ~/burninggarden/devtools/vim/grepper.vim
" :noremap <C-F> lbvey <ESC> :call Grepper('<C-R>0') <CR>
" :command -nargs=1 F :call Grepper(<f-args>)

function! Grepper(query)
	" Disabling this for now to see whether it enables grepping within other
	" git repos. If so, I'll just remove the line:

	" execute ':cd ~/burninggarden'
	let repo_location = system('~/vim-setup/bin/find-repo')
	execute ':cd ' . repo_location

	let results = system('git grep "' . a:query . '"')

	execute ':tabnew'
	setlocal filetype=text
	setlocal buftype=nofile

	call append(0, split(results, '\v\n'))
	normal! 1G
endfunction

:noremap <C-F> lbvey <ESC> :call Grepper('<C-R>0') <CR>
:command -nargs=1 F call Grepper(<f-args>)

autocmd Filetype ruby setlocal ts=2 sw=2 expandtab
