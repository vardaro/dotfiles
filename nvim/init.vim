set mouse=a
set number
set numberwidth=2
set cursorline
set clipboard=unnamed
set autoread
set hidden
set ignorecase

" Move fast with hjkl
nnoremap <C-J> :+5<CR>
nnoremap <C-K> :-5<CR>
nnoremap <C-L> w
nnoremap <C-H> b

" jj to exit insert mode, easier than reaching the ESC key with your pinky
inoremap jj <ESC>

" For when I fat finger the shift key
command Q q
command W w
command Wq wq
command Qa qa

" Bind :vsplit to 2, and move cursor to the new pane
nnoremap 2 :vsplit<CR><C-W><C-W>

" Insert empty line below cursor
nmap <Leader>o o<ESC>

call plug#begin('~/.vim/plugged')

" fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" main one
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
" 9000+ Snippets
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

" color theme
Plug 'bignimbus/pop-punk.vim'

" sensible
Plug 'tpope/vim-sensible'

" lightline
Plug 'itchyny/lightline.vim'

" Auto close parens
Plug 'raimondi/delimitmate'

" git
Plug 'tpope/vim-fugitive'

" indent things
Plug 'tpope/vim-sleuth'

" chad tree
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'ryanoasis/vim-devicons'

"lsp
Plug 'neovim/nvim-lspconfig'

Plug 'phaazon/hop.nvim'

call plug#end()

" set color
colorscheme pop-punk

lua require'hop'.setup()


" run coq now
autocmd VimEnter * COQnow -s

lua require("lsp_config")

autocmd BufWritePre *.go lua vim.lsp.buf.formatting()
autocmd BufWritePre *.go lua goimports(1000)

" fzf to ;
" prefer fd > find as fd will filter .gitignore directories
nnoremap ; :FZF<CR>
let $FZF_DEFAULT_COMMAND='fd --type f'

" ag to ctrl-;
nnoremap <C-P> :Ag<CR>

nnoremap e :HopWord<CR>

" open tree with e
nnoremap <space>e :CHADopen<CR>

" By default COQ nvim binds <C-H> to something I don't really care about.
" Unbinds <C-H>
let g:coq_settings = { "keymap.jump_to_mark": v:null }

" show rel path in lightline
let g:lightline = {
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ }
      \ }

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

