set mouse=a
set number
set numberwidth=2
set cursorline
set clipboard=unnamed
set autoread
set hidden
set ignorecase
set nowrap

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'bignimbus/pop-punk.vim'
Plug 'tpope/vim-sensible'
Plug 'itchyny/lightline.vim'
Plug 'raimondi/delimitmate'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'ryanoasis/vim-devicons'
Plug 'neovim/nvim-lspconfig'
Plug 'phaazon/hop.nvim'

call plug#end()

" Keybinds

" Skip lines/words with hjkl
nnoremap <C-J> :+5<CR>
nnoremap <C-K> :-5<CR>
nnoremap <C-L> w
nnoremap <C-H> b

" Press jj to exit insert mode, faster than reaching the ESC key with pinky
inoremap jj <ESC>

command Q q
command W w
command Wq wq
command Qa qa

" Bind :vsplit to 2, and move cursor to the new pane
nnoremap 2 :vsplit<CR><C-W><C-W>

" Insert empty line below cursor
nmap <Leader>o o<ESC>

" Set color
colorscheme pop-punk

" Setup hot.nvim
lua require'hop'.setup()

" Run COQnow to invoke autocomplete server
autocmd VimEnter * COQnow -s

" By default COQ nvim binds <C-H> to something I don't really care about.
" Unbinds <C-H>
let g:coq_settings = { "keymap.jump_to_mark": v:null }

" Native LSP client
lua require("lsp_config")

autocmd BufWritePre *.go lua vim.lsp.buf.formatting()
autocmd BufWritePre *.go lua goimports(1000)

" Bind fzf to ;
" prefer 'fd' over 'find' as fd will filter .gitignore directories
nnoremap ; :FZF<CR>
let $FZF_DEFAULT_COMMAND='fd --type f'

" History to '
nnoremap ' :History<CR>

" Bind hop.nvim to e
nnoremap e :HopWord<CR>

" Show path to buffer in lightline
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

