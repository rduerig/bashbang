" Setting some decent VIM settings for programming

set scrolloff=20		" keeps cursor in focus
set nu				" line numbers
set ai                          " set auto-indenting on for programming
set showmatch                   " automatically show matching brackets. works like it does in bbedit.
set ruler                       " show the cursor position all the time
set laststatus=2                " make the last line where the status is two lines deep so you can see status always
set backspace=indent,eol,start  " make that backspace key work the way it should
set nocompatible                " vi compatible is LAME
set background=dark             " Use colours that work well on a dark background (Console is usually black)
set showmode                    " show the current mode
set hlsearch			" turns on highlighting search results
syntax on                       " turn syntax highlighting on by default

" Show EOL type and last modified timestamp, right after the filename
set statusline=%<%F%h%m%r\ [%{&ff}]\ (%{strftime(\"%H:%M\ %d/%m/%Y\",getftime(expand(\"%:p\")))})%=%l,%c%V\ %P

" set guifont=Consolas:h10

" MAPPINGS
" maps ö to 0 - go to start of line
noremap ö 0
" maps ä to $ - go to end of line
noremap ä $
" hit SPACE to clear highlighted search results
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
" maps ü to CTRL-] - jump to topic under cursor
nnoremap ü <C-]>

" MAPPING LEADER
" hit leader-sp to turn spell checking on
noremap <Leader>sp :setlocal spell spelllang=en_us
" hit leader-spo to turn spell checking off
noremap <Leader>spo :setlocal nospell
" hit leader-gs to invoke git status
noremap <Leader>gs :!git status
" hit leader-gc to invoke git commit -a
noremap <Leader>gc :!git commit -a
" hit leader-gps to invoke git push 
noremap <Leader>gps :!git push bitbucket master

" COMMANDS
command Done :normal s++<ESC> k dd :m$<CR>g; 

"------------------------------------------------------------------------------
" Only do this part when compiled with support for autocommands.
if has("autocmd")
    "Set UTF-8 as the default encoding for commit messages
    autocmd BufReadPre COMMIT_EDITMSG,git-rebase-todo setlocal fileencodings=utf-8

    "Remember the positions in files with some git-specific exceptions"
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$")
      \           && expand("%") !~ "COMMIT_EDITMSG"
      \           && expand("%") !~ "ADD_EDIT.patch"
      \           && expand("%") !~ "addp-hunk-edit.diff"
      \           && expand("%") !~ "git-rebase-todo" |
      \   exe "normal g`\"" |
      \ endif

      autocmd BufNewFile,BufRead *.patch set filetype=diff
      autocmd BufNewFile,BufRead *.diff set filetype=diff

      autocmd Syntax diff
      \ highlight WhiteSpaceEOL ctermbg=red |
      \ match WhiteSpaceEOL /\(^+.*\)\@<=\s\+$/

      autocmd Syntax gitcommit setlocal textwidth=74

      autocmd Filetype java setlocal omnifunc=javacomplete#Complete
endif " has("autocmd")

" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

"let g:Tex_ViewRule_pdf = 'texworks'

let g:Tex_DefaultTargetFormat = 'pdf'

let g:Tex_MultipleCompileFormats = 'dvi,pdf'

" guicolorscheme.vim plugin specific settings
" IMPORTANT: Uncomment one of the following lines to force
" " using 256 colors (or 88 colors) if your terminal supports it,
" " but does not automatically use 256 colors by default.
set t_Co=256
"set t_Co=88
if (&t_Co == 256 || &t_Co == 88) && !has('gui_running') &&
			\ filereadable(expand("$HOME/.vim/plugin/guicolorscheme.vim"))
	" Use the guicolorscheme plugin to makes 256-color or 88-color
	" terminal use GUI colors rather than cterm colors.
	runtime! plugin/guicolorscheme.vim
	"GuiColorScheme wombat256mod
	colorscheme wombat256mod
else
	" For 8-color 16-color terminals or for gvim, just use the
	" regular :colorscheme command.
	colorscheme wombat256mod
endif

if (has('gui_running'))
  set guioptions-=T  "remove toolbar
endif

" In the mappings below, the first will make <C-N> work the way it normally
" does; however, when the menu appears, the <Down> key will be simulated. What
" this accomplishes is it keeps a menu item always highlighted. This way you
" can keep typing characters to narrow the matches, and the nearest match will
" be selected so that you can hit Enter at any time to insert it. The second one is a little more exotic: it simulates <C-X><C-O> to
" bring up the omni completion menu, then it simulates <C-N><C-P> to remove
" the longest common text, and finally it simulates <Down> again to keep a
" match highlighted.
"inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
"  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
"inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
"  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
