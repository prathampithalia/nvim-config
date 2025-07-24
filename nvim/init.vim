call plug#begin()


" Theme and Statusline
Plug 'ellisonleao/gruvbox.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'shaunsingh/solarized.nvim'

" File Navigation
Plug 'nvim-tree/nvim-tree.lua'
Plug 'preservim/nerdtree'

" Snippets & Autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rafamadriz/friendly-snippets'
Plug 'windwp/nvim-autopairs'

" Code Formatting
Plug 'mhartington/formatter.nvim'

" Terminal
Plug 'voldikss/vim-floaterm'

" Rainbow brackets (optional)
Plug 'HiPhish/rainbow-delimiters.nvim'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Commenting
Plug 'numToStr/Comment.nvim'

" Performance
Plug 'lewis6991/impatient.nvim'

" Telescope fuzzy finder
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.6' }
Plug 'nvim-lua/plenary.nvim' " Telescope dependency



call plug#end()


"## General Editor Settings -------------------------------------------------------------

syntax on
set smartcase
set tabstop=4
set nocompatible
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set ruler
set showcmd
set incsearch
set shellslash
set number
set relativenumber
set cino+=L0
set cmdheight=2
set clipboard=unnamed

" Enable syntax-based folding
set foldmethod=syntax
set foldlevel=99        " Start with all folds open
set foldenable          " Enable folding
set foldnestmax=3       " Optional: limit nested folds






" Shortcuts -------------------------------------------------------------

" ## For Folding and unfolding
" Press zc — close fold
" Press zo — open fold
" Press za — toggle fold
" zR — open all folds
" zM — close all folds
"  <C-P> to find files 


"## Line Movement
noremap H ddkkp
noremap N ddp

" Select inside curly braces using Ctrl+K (Ctrl+Shift+K often maps to Ctrl+K)
nnoremap <C-K> vi{

inoremap <silent><expr> <TAB> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


" Font SIZE -------------------------------------------------------------
let s:fontsize = 12
function! AdjustFontSize(amount)
  let s:fontsize = s:fontsize + a:amount
  " Use the exact font name 'JetBrains Mono' with a space.
  " GuiFont typically handles spaces correctly without needing backslashes.
  execute "GuiFont! JetBrains Mono:h" . s:fontsize
endfunction

noremap <C-ScrollWheelUp> :call AdjustFontSize(1)<CR>
noremap <C-ScrollWheelDown> :call AdjustFontSize(-1)<CR>

"## Status Line
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ [%{(&fenc==\"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")}]\ %c:%l/%L%)

"## Theme
set background=light
colorscheme Solarized

let g:airline_theme='simple'
let g:airline_solarized_bg='light'
let g:airline_powerline_fonts = 0
let g:rainbow_active = 1
let g:NERDTreeWinSize=20


"## Main Working Directory & Terminal -------------------------------------------------------------
cd C:\Users\ACER\Documents\nvim
:let &shell='C:\Windows\System32\cmd.exe'
let g:python3_host_prog = 'C:/Users/ACER/AppData/Local/Programs/Python/Python311/python.EXE'




"## Cpp Run & Build  -------------------------------------------------------------
function! StopBuild()
  if exists('t:build_job')
    call jobstop(t:build_job)
    unlet t:build_job
  else
    echo "No build process running"
  endif
endfunction

autocmd filetype cpp nnoremap <F5> :FloatermNew --position=right --wintype=float --autoclose=0 g++ -std=c++17 -O2 -Wall % -o %:r && %:r.exe <CR>
autocmd FileType cpp nnoremap <C-c> :call StopBuild()<CR>
autocmd FileType cpp nnoremap <C-b> :w<bar>!g++ -std=c++17 -O2 -Wall % -o %:r && %:r.exe <CR>



" Keep the path to your Python executable here.
let g:python3_host_prog = 'C:\Users\ACER\AppData\Local\Programs\Python\Python312\python.exe'


"## Layout -------------------------------------------------------------
function! SetupSplits()
  " Open nvim-tree using Lua API
  silent! lua require("nvim-tree.api").tree.open()

  " Start a timer to delay the window split setup
  call timer_start(100, { -> SetupRightSplits() })
endfunction

function! SetupRightSplits()
  " Move to the right window
  wincmd l

  " Create vertical split and open input.txt
  vsplit
  wincmd l
  edit input.txt

  " Create horizontal split and open output.txt
  split
  edit output.txt

  " Move focus back to nvim-tree on the left
  wincmd h
endfunction

autocmd VimEnter * call SetupSplits()



"## LUA CODE -------------------------------------------------------------

lua << EOF

require('nvim-autopairs').setup({})

-- Your existing listchars settings
vim.opt.list = true
vim.opt.listchars = {
  tab = '» ',
 -- leadmultispace = '· ',
--  trail = '␣',
  extends = '▶',
  precedes = '◀',
-- nbsp = '␣',
}



require'nvim-treesitter.configs'.setup {
  ensure_installed = { "python", "lua", "json"},
  highlight = { enable = true },
}

require('Comment').setup()
require('lualine').setup()
require('telescope').setup{}

-- Keybinding for Ctrl + P to find files
vim.api.nvim_set_keymap('n', '<C-p>', ":Telescope find_files<CR>", { noremap = true, silent = true })


require('formatter').setup({
  logging = false,
  filetype = {
    cpp = {
      function()
        return {
          exe = "astyle",
          args = { "--style=google", "--convert-tabs", "--suffix=none" }, -- Customize the style as needed
          stdin = true,
        }
      end
    },
  }
})

EOF
nnoremap <silent> <C-S-i> :Format<bar>%s/\r//g<CR>