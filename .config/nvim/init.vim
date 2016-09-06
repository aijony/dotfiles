"
"   ██╗     ███████╗     ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗ 
"   ██║     ██╔════╝    ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝ 
"   ██║     █████╗      ██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗
"   ██║     ██╔══╝      ██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║
"   ███████╗███████╗    ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝
"   ╚══════╝╚══════╝     ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝ 
"
"
"            ^^                   @@@@@@@@@
"       ^^       ^^            @@@@@@@@@@@@@@@
"                            @@@@@@@@@@@@@@@@@@              ^^
"                           @@@@@@@@@@@@@@@@@@@@
" ~~~~ ~~ ~~~~~ ~~~~~~~~ ~~ &&&&&&&&&&&&&&&&&&&& ~~~~~~~ ~~~~~~~~~~~ ~~~
" ~         ~~   ~  ~       ~~~~~~~~~~~~~~~~~~~~ ~       ~~     ~~ ~
"   ~      ~~     ~~ ~~ ~~  ~~~~~~~~~~~~~ ~~~~  ~     ~~~    ~ ~~~  ~ ~~
"   ~  ~~     ~   ~      ~      ~~~~~~  ~~ ~~~       ~~ ~ ~~  ~~ ~
" ~  ~       ~ ~      ~           ~~ ~~~~~~  ~      ~~  ~             ~~
"       ~             ~        ~      ~      ~~   ~             ~

"Basic Vim Configurations

" Display Settings
set relativenumber
set number
syntax enable
set background=dark

" Cache Settings
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview 
set viminfo+=n~/.vim/viminfo

"Neovim Specific Configurations

" Terminal Settings
tnoremap <ESC> <C-\><C-n><C-w><C-p>
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert


"Plugin Configurations

"Vim-Plugged
call plug#begin('~/.config/nvim/plugged')

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Vim solarized unmanaged (manually installed and updated)
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdcommenter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'bling/vim-airline'
Plug 'Yggdroot/indentLine'
Plug 'Valloric/YouCompleteMe'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'mhinz/vim-startify'
Plug 'mklabs/split-term.vim'

call plug#end()

"Base16-shell
if filereadable(expand("~/.vim/base16.vimrc"))
  let colorspace=256
  "let base16colorspace=256
  source ~/.vim/base16.vimrc 
endif

"Syntastic

" Recommended settings

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" C++ Settings
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

"fugitive.vim... awesome
" IGUESS THIS ISN'T NEEDED! vim -u NONE -c "helptags vim-fugitive/doc" -c q

"Powerline
" Smarter tab line
let g:airline#extensions#tabline#enabled = 1 
let g:airline#extensions#tabline#show_tabs = 0 
"  Straight Tabs
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'

"YouCompleteMe options

let g:ycm_register_as_syntastic_checker = 1 "default 1
let g:Show_diagnostics_ui = 1 "default 1

"will put icons in Vim's gutter on lines that have a diagnostic set.
"Turning this off will also turn off the YcmErrorLine and YcmWarningLine
"highlighting
let g:ycm_enable_diagnostic_signs = 1
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_always_populate_location_list = 1 "default 0
let g:ycm_open_loclist_on_ycm_diags = 1 "default 1


let g:ycm_complete_in_strings = 1 "default 1
let g:ycm_collect_identifiers_from_tags_files = 0 "default 0
let g:ycm_path_to_python_interpreter = '' "default ''


let g:ycm_server_use_vim_stdout = 0 "default 0 (logging to console)
let g:ycm_server_log_level = 'info' "default info


let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'  "where to search for .ycm_extra_conf.py if not found
let g:ycm_confirm_extra_conf = 1


let g:ycm_goto_buffer_command = 'same-buffer' "[ 'same-buffer', 'horizontal-split', 'vertical-split', 'new-tab' ]
let g:ycm_filetype_whitelist = { '*': 1 }
let g:ycm_key_invoke_completion = '<C-Space>'

"Preview Options
let g:ycm_add_preview_to_completeopt = 1 "default 0
let g:ycm_autoclose_preview_window_after_completion = 1 "default = 0

nnoremap <F11> :YcmForceCompileAndDiagnostics <CR>


