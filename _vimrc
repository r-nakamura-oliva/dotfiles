"*****************************************************************************
"" dein Settings
"*****************************************************************************"
" TODO: XDG Base Directory Specification に対応しないなら変更する必要あり
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir .'/repos/github.com/Shougo/dein.vim'

" autocmd が複数登録されないように最初に削除
" dein.toml で MyAutoCmd を使うので dein.toml を読み込む前に定義
augroup MyAutoCmd
  autocmd!
augroup END

" dein.vimを自動でインストール.
" system はシェルの実行、shellescapeはシェルで利用できる文字列に変換
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif

" dein.vim本体をruntimepathに自己代入.つまりプラグインとして読み込む.
" TODO:下記の場合 rintaro の部分が固定で他の環境で使えないので修正.
" set runtimepath+=/Users/rintaro/.cache/dein/repos/github.com/Shougo/dein.vim
"  => set runtimepath+=s:dein_repo_dir がエラーになる理由が分からない.
" 上記では set しているが参考サイトでは下記のように let を使っているがそれぞれのメリデメが分からない.
" 参考サイト : https://qiita.com/kawaz/items/ee725f6214f91337b42b
let &runtimepath = s:dein_repo_dir .",". &runtimepath

" プラグイン読み込み&キャッシュ作成.
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let s:plugings_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
  call dein#load_toml(s:plugings_file)

  call dein#end()
  call dein#save_state()
endif

" 起動時に不足プラグインを自動でインストール.
if has('vim_starting') && dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable
"*****************************************************************************
"" End dein Settings
"*****************************************************************************"

"*****************************************************************************
"" Basic Settings
"*****************************************************************************"
" VimをVi互換モードではなく、Vimとして使用(compatibleオプションはデフォルトで有効だが、vimrc/gvimrcを読み込むと無効になる)
if &compatible
  set nocompatible
endif

" 検索パターンに大文字小文字を区別しない
set ignorecase
" インクリメンタルサーチ. １文字入力毎に検索を行う
set incsearch
" 検索パターンに大文字を含んでいたら大文字小文字を区別する
set smartcase
" 検索結果をハイライト"
set hlsearch

" タブをスペースに変換する
set expandtab
" ファイル上のタブ文字の幅
set tabstop=2
" 連続した空白に対してタブキーやバックスペースでカーソルが動く幅
set softtabstop=2
" 改行時に前の行の構文をチェックし次の行のインデントを増減する
set smartindent
" smartindentで増減する幅
set shiftwidth=2

" 行数を表示
set number
" ファイルタイトルを表示
set title
" -(ハイフン)を単語に含める
set isk+=-
" vimの256色対応
set t_Co=256
" クリップボード
set clipboard=unnamed
" indent: 行頭の空白, eol: 改行, start: 挿入モード開始位置より手前の文字でバックスペースを有効化
set backspace=indent,eol,start
" □や○文字が崩れる問題を解決
set ambiwidth=double
" Vimの「%」を拡張する
source $VIMRUNTIME/macros/matchit.vim
" コマンドモードの補完
set wildmenu
" 不可視文字を表示する
set list
" タブを -- 半スペを - で表示する
set lcs=tab:>-,trail:-
" 末尾に改行がついていないファイルを編集し保存するとファイル末尾に改行追加されるのを防ぐ
set nofixeol
" マウスでカーソル移動やスクロール移動を可能に.
" if has('mouse')
"     set mouse=a
"     if has('mouse_sgr')
"         set ttymouse=sgr
"     elseif v:version > 703 || v:version is 703 && has('patch632')
"         set ttymouse=sgr
"     else
"         set ttymouse=xterm2
"     endif
" endif

" ファイルの分割
nnoremap <silent> <Space>x :<C-u>split<CR>
nnoremap <silent> <Space>v :<C-u>vsplit<CR>
" ウィンドウ間におけるカーソルの移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" ナイスなVimの設定を思いついたら即座にvimrcを開き反映
nnoremap <F5> :<C-u>split $MYVIMRC<CR>
nnoremap <F6> :<C-u>source $MYVIMRC<CR>
" ヤンクした内容が消えないようにする
nnoremap PP "0p
" ウィンドウ入れ替え
" 現在カーソルがあるウィンドウと一つ前のウィンドウを入れ替える
nnoremap <C-w> <C-w>x

" 括弧の補完
inoremap " ""<Left>
inoremap ' ''<Left>
inoremap { {}<Left>
inoremap [ []<Left>
inoremap ( ()<Left>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>

inoremap <C-l> <Right>
"*****************************************************************************
"" End Basic Settings
"*****************************************************************************"

"*****************************************************************************
" Autocmd
" 必ずaugroup名を指定して書く
" *で全ファイルに適用
"*****************************************************************************
" 保存時に行末スペースを取り除く TODO: 全角対応
" eフラグは検索パターンが何もマッチしなかった時に、エラーメッセージを表示させないため
" autocmd MyAutoCmd BufWritePre * %s/\s\+$//e

autocmd MyAutoCmd BufRead,BufNewFile *.md set filetype=markdown

" vimgrep
"" vimgrep,grep,Ggrepで自動的にquickfix-window(:cw)を開く.
autocmd MyAutoCmd QuickFixCmdPost *grep* cwindow
"" vimgrepの検索対象外ファイル・ディレクトリを設定.
let s:ignore_list  = ',.git/**,.svn/**,obj/**'
let s:ignore_list .= ',tags,GTAGS,GRTAGS,GPATH'
let s:ignore_list .= ',*.o,*.obj,*.exe,*.dll,*.bin,*.so,*.a,*.out,*.jar,*.pak'
let s:ignore_list .= ',*.zip,*gz,*.xz,*.bz2,*.7z,*.lha,*.lzh,*.deb,*.rpm,*.iso'
let s:ignore_list .= ',*.pdf,*.png,*.jp*,*.gif,*.bmp,*.mp*'
let s:ignore_list .= ',*.od*,*.doc*,*.xls*,*.ppt*'

if exists('+wildignore')
  autocmd MyAutoCmd QuickFixCmdPre  * execute 'setlocal wildignore+=' . s:ignore_list
  autocmd MyAutoCmd QuickFixCmdPost * execute 'setlocal wildignore-=' . s:ignore_list
endif

" htmlの閉じタグ補完.
autocmd MyAutoCmd Filetype xml  inoremap <buffer> </ </<C-x><C-o>
autocmd MyAutoCmd Filetype html inoremap <buffer> </ </<C-x><C-o>

" ファイルを開いてカーソルの位置を元に戻す.
autocmd MyAutoCmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" 保存時にファイルをリロードする.
autocmd MyAutoCmd BufWritePost $MYVIMRC source $MYVIMRC
"*****************************************************************************
" End Autocmd
"*****************************************************************************
