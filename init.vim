" https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim
let vimroot = expand("<sfile>:p:h")
" 不加载 python2
let g:loaded_python_provider = 0
if $NEOVIM_PYTHON_HOST_PROG != ""
  let g:python_host_prog = $NEOVIM_PYTHON_HOST_PROG
else
  let g:python_host_prog = vimroot.'/provider/python/neovim2/bin/python'
endif
if $NEOVIM_PYTHON3_HOST_PROG != ""
  let g:python3_host_prog = $NEOVIM_PYTHON3_HOST_PROG
else
  let g:python3_host_prog = vimroot.'/provider/python/neovim3/bin/python'
endif

let g:coc_data_home = vimroot.'/coc'

if vimroot != stdpath('config')
  " 只加载与 init.vim 同一目录下的 .vim 目录内容
  let &rtp = substitute(&rtp, stdpath('config'), vimroot, "g")
endif

" Plugins will be downloaded under the specified directory.
call plug#begin(vimroot.'/plugged')

Plug 'sheerun/vim-polyglot'
" 文件浏览器，NerdTree命令
Plug 'scrooloose/nerdtree',
"Plug 'Lokaltog/vim-powerline'
Plug 'vim-airline/vim-airline'
" 注释管理插件
Plug 'scrooloose/nerdcommenter'
" 强大的git工具
Plug 'tpope/vim-fugitive'
" 快速删除/修改光标周围配对的括号
Plug 'tpope/vim-surround'
" Ack-grep插件。需要先安裝ack-grep
Plug 'mileszs/ack.vim'
" zencoding的升级版 使用 coc-emmet 代替
Plug 'mattn/emmet-vim'
" 另一个buffer浏览
Plug 'vim-scripts/bufexplorer.zip'
" 代码格式化插件
Plug 'sbdchd/neoformat'
" Complete engine and Language Server
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/jsonc.vim'

" 提供异步操作，需要执行 :UpdateRemotePlugins
Plug 'Shougo/denite.nvim'
" 多文件查找替换
Plug 'brooth/far.vim'
" sudo 插件
Plug 'lambdalisue/suda.vim'
" vue 语法高亮
Plug 'posva/vim-vue'
" typescript react
Plug 'ianks/vim-tsx'
" rails
Plug 'tpope/vim-rails'
" github copilot
" Plug 'github/copilot.vim'
" 光标瞬移 <Leader><Leader>s <char>
Plug 'easymotion/vim-easymotion'

Plug 'editorconfig/editorconfig-vim'

" fuzzy finder
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }

" 需要先安装 pip3 install ranger-fm pynvim
Plug 'kevinhwang91/rnvimr'

Plug 'navarasu/onedark.nvim'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()


colorscheme onedark

" 覆盖coc.vim的配置
let $VIMCONFIG=vimroot

set mouse=    "禁用鼠标
set cursorline
" set autochdir  "自动切换目录
set cc=81 " 81列处高亮
set nu " 显示行号
set list  " 把制表符显示为^I ,用$标示行尾（使用list分辨尾部的字符是tab还是空格）
set listchars=tab:>-,trail:·
" 文件编码
set encoding=utf8
set fileencodings=utf8,gb2312,gb18030,ucs-bom,latin1

set foldlevel=10 "默认展开所有代码
set foldmethod=indent

set showtabline=2  " 0, 1 or 2; when to use a tab pages line
" set tabline=%!MyTabLine()  " custom tab pages line

function! MyTabLine()
  let s = ''
  let t = tabpagenr()
  let i = 1
  while i <= tabpagenr('$')
    let buflist = tabpagebuflist(i)
    let winnr = tabpagewinnr(i)
    let s .= '%' . i . 'T'
    let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
    let bufnr = buflist[winnr - 1]
    let file = bufname(bufnr)
    let buftype = getbufvar(bufnr, 'buftype')
    if buftype == 'nofile'
      if file =~ '\/.'
        let file = substitute(file, '.*\/\ze.', '', '')
      endif
    else
      let file = fnamemodify(file, ':p:t')
    endif
    if file == ''
      let file = '[No Name]'
    endif
    let s .= string(i) . ":"
    let file = strpart(file, 0, 25)
    let s .= file
    let i = i + 1
  endwhile
  let s .= '%T%#TabLineFill#%='
  let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
  return s
endfunction

" 替换选定区域为升序的数字，如： ::s/<pattern>/\=ReplaceInc(1, 2, 'v')/g
function! ReplaceInc(start=1, step=1, mode='v', length=1)
  let result = a:start
  if a:mode == 'v'
    " 选择模式下，当前行减去选中的第一行
    let result = (line('.') - line("'<")) * a:step
  else
    " 普通模式下，当前行减去第一行
    let result = (line('.') - 1) * a:step
  endif
  let result = result + a:start
  let format = "%0" . a:length . "d"
  let result = printf(format, result)
  return result
endfunction

" 插入一些行，包含升序的数字
function! InsertInc(start, end, length=1, step=1, prefix='', suffix='')
  let format = "%s%0" . a:length . "d%s"
  for i in range(a:start, a:end, a:step)
    put =printf(format, a:prefix, i, a:suffix)
  endfor
endfunction

" keymap
nmap <C-n> <ESC>gt
nmap <C-p> <ESC>gT
vmap <C-x>c "+y
nmap <C-x>c "+p
map <C-x>q :qa<CR>
imap <C-u> <ESC><C-u>
imap <C-d> <ESC><C-d>
imap <C-b> <ESC>i
imap <C-f> <ESC>la
" 窗口移动
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l

set tabstop=2 expandtab shiftwidth=2 softtabstop=2
au FileType python setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4
au FileType c setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4
au FileType cpp setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4
au FileType vue syntax sync fromstart
autocmd BufNewFile,BufRead *.nvue   set syntax=vue


" NERDTree 设置
let g:NERDTreeShowHidden=1 " 显示隐藏文件
let g:NERDTreeWinPos="left"
let g:NERDTreeIgnore=['\~$', '\.pyo$', '\.bak$']
let g:NERDTreeQuitOnOpen=1 " 打开文件后关闭
noremap ;l :NERDTreeToggle<CR>

" 与VSCode一样，使用TAB来补全 snippet
" Use <Tab> and <S-Tab> for navigate completion list:
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'
" Use <enter> to confirm complete
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
"autocmd CompleteDone * pclose       " 自动关闭自动补全的Preview window

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" airline
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
let g:airline_section_b = ''  " 不显示VCS相关信息

" emmet设置
let g:user_emmet_leader_key='<c-x>'

" nvim-telescope配置，需要禁用 autochdir
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" rnvimr Ranger 配置
" Make Ranger to be hidden after picking a file
let g:rnvimr_enable_picker = 1
nnoremap <F4> <cmd>RnvimrToggle<cr>
" Map Rnvimr action
let g:rnvimr_action = {
            \ '<C-t>': 'NvimEdit tabedit',
            \ '<C-x>': 'NvimEdit split',
            \ '<C-v>': 'NvimEdit vsplit',
            \ 'gw': 'JumpNvimCwd',
            \ 'yw': 'EmitRangerCwd'
            \ }
