"---------------------------------------------------------------------------
"        __             _       _                 _
"   ____/ /___   _____ (_)_____( )_____   _   __ (_)____ ___   _____ _____
"  / __  // _ \ / ___// // ___/|// ___/  | | / // // __ `__ \ / ___// ___/
" / /_/ //  __// /   / /(__  )  (__  )   | |/ // // / / / / // /   / /__
" \__,_/ \___//_/   /_//____/  /____/    |___//_//_/ /_/ /_//_/    \___/
"
"---------------------------------------------------------------------------

"---------------------------------------------------------------------------
" basic settings {{{1

if has('vim_starting') && has('reltime')
  let g:startuptime = reltime()
  augroup vimrc-startuptime
    autocmd! VimEnter * let g:startuptime = reltime(g:startuptime) | redraw
      \ | echomsg 'startuptime: ' . reltimestr(g:startuptime)
  augroup END
endif

if has('unix')
  let $DOTVIM=expand('~/.vim')
else
  let $DOTVIM=expand('~/vimfiles')
endif

let $VIMBUNDLE=$DOTVIM.'/bundle'
let $NEOBUNDLEPATH=$VIMBUNDLE.'/neobundle.vim'

function! s:bundled(bundle)
  if !isdirectory($VIMBUNDLE)
    return 0
  endif
  if stridx(&runtimepath, $NEOBUNDLEPATH) == -1
    return 0
  endif

  if a:bundle ==# 'neobundle.vim'
    return 1
  else
    return neobundle#is_installed(a:bundle)
  endif
endfunction

"---------------------------------------------------------------------------
" NeoBundle {{{2
filetype off

if has('vim_starting') && isdirectory($NEOBUNDLEPATH)
  set runtimepath+=$NEOBUNDLEPATH
endif

if s:bundled('neobundle.vim')
  call neobundle#rc($VIMBUNDLE)

  let g:neobundle_default_git_protocol = 'https'
  " original repos on github
  NeoBundle 'Shougo/neobundle.vim'
  "NeoBundle 'gmarik/vundle'
  NeoBundleLazy 'AndrewRadev/linediff.vim', {
    \ 'autoload' : {
    \   'commands' : [
    \     'Linediff',
    \     'LinediffReset',
    \   ],
    \ }}
  NeoBundleLazy 'AndrewRadev/splitjoin.vim', {
    \ 'autoload' : {
    \   'commands' : [
    \     'SplitjoinSplit',
    \     'SplitjoinJoin',
    \   ],
    \ }}
  NeoBundleLazy 'AndrewRadev/switch.vim', { 'autoload' : {
    \ 'commands' : 'Switch',
    \ }}
  NeoBundle 'AndrewRadev/vimrunner'
  "NeoBundle 'FredKSchott/CoVim'
  "NeoBundleLazy 'Lokaltog/vim-easymotion'
  NeoBundle 'LeafCage/yankround.vim'
  "NeoBundle 'Lokaltog/powerline', {
    "\ 'rtp' : '~/.vim/bundle/powerline/powerline/bindings/vim',
    "\ }
  "NeoBundle 'Raimondi/delimitMate'
  "NeoBundleLazy 'Rip-Rip/clang_complete', { 'autoload' : {
    "\ 'filetypes' : ['c', 'cpp'],
    "\ }}
  "NeoBundleLazy 'Shougo/neocomplcache-rsense', {
  "  \ 'depends' : 'Shougo/neocomplcache',
  "  \ 'autoload' : {
  "  \   'filetypes' : ['ruby', 'eruby', 'haml'],
  "  \ }}
  NeoBundle 'Shougo/neocomplete', '', 'default'
  call neobundle#config('neocomplete', {
    \ 'lazy' : 1,
    \ 'autoload' : {
    \   'insert' : 1,
    \ }})
  NeoBundle 'Shougo/neosnippet', '', 'default'
  call neobundle#config('neosnippet', {
    \ 'lazy' : 1,
    \ 'autoload' : {
    \   'insert' : 1,
    \   'filetypes' : 'snippet',
    \   'commands' : ['NeoSnippetEdit'],
    \   'unite_sources' : ['snippet', 'neosnippet/user', 'neosnippet/runtime'],
    \ }})
  NeoBundle 'Shougo/neosnippet-snippets'
  NeoBundle 'Shougo/unite.vim', '', 'default'
  call neobundle#config('unite.vim',{
    \ 'lazy' : 1,
    \ 'autoload' : {
    \   'commands' : [{ 'name' : 'Unite',
    \                   'complete' : 'customlist,unite#complete_source'},
    \                 'UniteWithCursorWord', 'UniteWithInput']
    \ }})
  NeoBundleLazy 'Shougo/unite-help', { 'autoload' : {
    \ 'unite_sources' : 'help',
    \ }}
  NeoBundle 'Shougo/unite-outline', '', 'default'
  call neobundle#config('unite-outline', {
    \ 'lazy' : 1,
    \ 'autoload' : {
    \   'unite_sources' : 'outline',
    \ }})
  NeoBundle 'Shougo/vimfiler', '', 'default'
  call neobundle#config('vimfiler', {
    \ 'lazy' : 1,
    \ 'depends' : 'Shougo/unite.vim',
    \ 'autoload' : {
    \   'commands' : [
    \                 { 'name' : 'VimFiler',
    \                   'complete' : 'customlist,vimfiler#complete' },
    \                 { 'name' : 'VimFilerTab',
    \                   'complete' : 'customlist,vimfiler#complete' },
    \                 { 'name' : 'VimFilerExplorer',
    \                   'complete' : 'customlist,vimfiler#complete' },
    \                 { 'name' : 'Edit',
    \                   'complete' : 'customlist,vimfiler#complete' },
    \                 { 'name' : 'Write',
    \                   'complete' : 'customlist,vimfiler#complete' },
    \                 'Read', 'Source'],
    \   'mappings' : ['<Plug>(vimfiler_switch)'],
    \   'explorer' : 1,
    \ }})
  NeoBundle 'Shougo/vimproc.vim', '', 'default'
  call neobundle#config('vimproc.vim', {
    \ 'build' : {
    \     'windows' : 'make -f make_mingw32.mak',
    \     'cygwin'  : 'make -f make_cygwin.mak',
    \     'mac'     : 'make -f make_mac.mak',
    \     'unix'    : 'make -f make_unix.mak',
    \    },
    \ })
  NeoBundle 'Shougo/vimshell', '', 'default'
  call neobundle#config('vimshell', {
    \ 'lazy' : 1,
    \ 'autoload' : {
    \   'commands' : [{ 'name' : 'VimShell',
    \                   'complete' : 'customlist,vimshell#complete'},
    \                 'VimShellExecute', 'VimShellInteractive',
    \                 'VimShellTerminal', 'VimShellPop'],
    \   'mappings' : ['<Plug>(vimshell_switch)']
    \ }})
  NeoBundle 'Townk/vim-autoclose'
  " NeoBundle 'Valloric/MatchTagAlways'
  NeoBundle 'airblade/vim-rooter'
  "NeoBundle 'airblade/vim-gitgutter'
  "NeoBundle 'akiomik/git-gutter-vim'
  NeoBundleLazy 'basyura/J6uil.vim', {
    \ 'autoload' : {
    \   'commands' : [
    \     'J6uil',
    \   ],
    \   'unite_sources' : [
    \     'J6uil/rooms',
    \     'J6uil/members',
    \   ]},
    \ }
  "NeoBundle 'benmills/vimux'
  NeoBundle 'bitc/vim-bad-whitespace'
  NeoBundle 'bling/vim-airline'
  "NeoBundleLazy 'bkad/CamelCaseMotion', { 'autoload' : {
    "\ 'mappings' : ['<Plug>CamelCaseMotion_w',
    "\               '<Plug>CamelCaseMotion_b'],
    "\ }}
  NeoBundleLazy 'bootleq/ShowMarks'
  NeoBundleLazy 'choplin/unite-vim_hacks', { 'autoload' : {
    \ 'unite_sources' : 'vim_hacks',
    \ }}
  NeoBundleLazy 'chrisbra/NrrwRgn', {
    \ 'autoload' : {
    \   'commands' : [
    \     'NR',
    \     'NarrowRegion',
    \     'NW',
    \     'NarrowWindow',
    \   ]},
    \ }
  NeoBundleLazy 'chrisbra/SudoEdit.vim', {
    \ 'autoload' : {
    \   'commands' : [
    \     'SudoRead',
    \     'SudoWrite',
    \   ]},
    \ }
  NeoBundle 'coderifous/textobj-word-column.vim'
  NeoBundleLazy 'c9s/perlomni.vim', { 'autoload' : {
    \ 'filetypes' : ['perl']
    \ }}
  NeoBundleLazy 'dahu/vim-fanfingtastic'
  NeoBundleLazy 'daisuzu/rainbowcyclone.vim'
  "NeoBundleLazy 'davidhalter/jedi-vim', { 'autoload' : {
    "\ 'filetypes' : ['python', 'python3'],
    "\ }}
  NeoBundleLazy 'derekwyatt/vim-scala', { 'autoload' : {
    \ 'filetypes' : ['scala']
    \ }}
  NeoBundleLazy 'deton/jasegment.vim'
  NeoBundleLazy 'dhruvasagar/vim-table-mode', {
    \ 'autoload' : {
    \   'commands' : [
    \     'Tableize',
    \     'TableAddFormula',
    \     'TableEvalEfomulaLine',
    \   ]},
    \ }
  NeoBundle 'emonkak/vim-operator-comment',
    \ { 'depends' : 'kana/vim-operator-user' }
  "NeoBundle 'emonkak/vim-operator-sort',
    "\ { 'depends' : 'kana/vim-operator-user' }
  "NeoBundle 'fholgado/minibufexpl.vim'
  "NeoBundle 'fkfk/rbpit.vim'
  "NeoBundle 'fuenor/qfixgrep'
  "NeoBundle 'fuenor/qfixhowm'
  "NeoBundle 'godlygeek/tabular'
  NeoBundleLazy 'goldfeld/vim-seek'
  NeoBundle 'google/maktaba'
  NeoBundleLazy 'gregsexton/gitv', {
    \ 'depends' : 'tpope/vim-fugitive',
    \ 'autoload' : {
    \   'commands' : [
    \     'Gitv',
    \   ]},
    \ }
  NeoBundleLazy 'h1mesuke/vim-alignta', {
    \ 'autoload' : {
    \   'commands' : [
    \     'Alignta',
    \   ]},
    \ }
  NeoBundle 'h1mesuke/vim-benchmark'
  NeoBundle 'h1mesuke/textobj-wiw',
    \ { 'depends' : 'kana/vim-textobj-user' }
  "NeoBundle 'hekyou/vim-rectinsert'
  "NeoBundle 'houtsnip/vim-emacscommandline'
  NeoBundleLazy 'int3/vim-extradite', {
    \ 'depends' : 'tpope/vim-fugitive',
    \ 'autoload' : {
    \   'commands' : [
    \     'Extradite',
    \   ]},
    \ }
  NeoBundleLazy 'itchyny/calendar.vim', {
    \ 'autoload' : {
    \   'commands' : [
    \     'Calendar',
    \   ]},
    \ }
  NeoBundleLazy 'itchyny/thumbnail.vim', {
    \ 'autoload' : {
    \   'commands' : [
    \     'Thumbnail',
    \   ]},
    \ }
  "NeoBundle 'jceb/vim-orgmode'
  "NeoBundleLazy 'jceb/vim-hier'
  NeoBundleLazy 'jelera/vim-javascript-syntax', { 'autoload' : {
    \ 'filetypes' : 'javascript',
    \ }}
  "NeoBundleLazy 'jerrymarino/xcodebuild.vim'
  NeoBundleLazy 'jiangmiao/simple-javascript-indenter', { 'autoload' : {
    \ 'filetypes' : 'javascript',
    \ }}
  NeoBundleLazy 'joedicastro/vim-pentadactyl', {
    \ 'autoload': {'filetypes': ['pentadactyl']}}
  "NeoBundle 'jpalardy/vim-slime'
  NeoBundleLazy 'justinmk/vim-sneak'
  "NeoBundle 'lilydjwg/colorizer'
  NeoBundle 'lucapette/vim-textobj-underscore'
  NeoBundleLazy 'mutewinter/swap-parameters'
  "NeoBundle 'kana/vim-advice'
  NeoBundleLazy 'kana/vim-altr', {
    \ 'autoload' : {
    \   'functions' : [
    \     'altr#forward',
    \     'altr#back',
    \   ],
    \   'mappings' : [
    \     '<Plug>(altr-forward)',
    \     '<Plug>(altr-back)',
    \   ],
    \ }}
  NeoBundle 'kana/vim-arpeggio'
  NeoBundleLazy 'kana/vim-fakeclip'
  "NeoBundle 'kana/vim-gf-user'
  "NeoBundle 'kana/vim-grex'
  "NeoBundle 'kana/vim-metarw'
  NeoBundleLazy 'kana/vim-narrow', {
    \ 'autoload' : {
    \   'commands' : [
    \     'Narrow',
    \     'Widen',
    \   ]},
    \ }
  NeoBundle 'kana/vim-niceblock'
  NeoBundle 'kana/vim-operator-user'
  NeoBundle 'kana/vim-operator-replace',
    \ { 'depends' : 'kana/vim-operator-user' }
  NeoBundleLazy 'kana/vim-scratch', {
    \ 'autoload' : {
    \   'commands' : [
    \     'ScratchOpen',
    \     'ScratchClose',
    \   ]},
    \ }
  NeoBundleLazy 'kana/vim-smartchr', { 'autoload' : {
    \ 'insert' : 1,
    \ }}
  NeoBundleLazy 'kana/vim-smartinput'
  NeoBundleLazy 'kana/vim-smarttill', {
    \ 'autoload' : {
    \   'mappings' : [
    \     '<Plug>(smarttill-t)',
    \     '<Plug>(smarttill-T)',
    \   ],
    \ }}
  NeoBundle 'kana/vim-smartword'
  NeoBundle 'kana/vim-submode'
  "NeoBundleLazy 'kana/vim-tabpagecd'
  NeoBundle 'kana/vim-textobj-user'
  NeoBundle 'kana/vim-textobj-entire',
    \ { 'depends' : 'kana/vim-textobj-user' }
  NeoBundle 'kana/vim-textobj-function',
    \ { 'depends' : 'kana/vim-textobj-user' }
  NeoBundle 'kana/vim-textobj-indent',
    \ { 'depends' : 'kana/vim-textobj-user' }
  "NeoBundle 'kana/vim-textobj-jabraces',
    "\ { 'depends' : 'kana/vim-textobj-user' }
  "NeoBundle 'kana/vim-textobj-lastpat',
    "\ { 'depends' : 'kana/vim-textobj-user' }
  NeoBundle 'kana/vim-textobj-line',
    \ { 'depends' : 'kana/vim-textobj-user' }
  "NeoBundle 'kana/vim-textobj-syntax',
    "\ { 'depends' : 'kana/vim-textobj-user' }
  NeoBundleLazy 'kana/vim-vspec'
  NeoBundleLazy 'kannokanno/vimtest'
  NeoBundleLazy 'kien/ctrlp.vim', {
    \ 'autoload' : {
    \   'commands' : [
    \     'CtrlPBuffer',
    \     'CtrlPMRUFiles',
    \     'CtrlPCurFile',
    \   ]},
    \ }
  "NeoBundle 'kshenoy/vim-signature'
  NeoBundleLazy 'majutsushi/tagbar', {
    \ 'autoload' : {
    \   'commands' : [
    \     'Tagbar'
    \   ]},
    \ }
  NeoBundleLazy 'mattn/asyncgrep-vim'
  NeoBundleLazy 'mattn/benchvimrc-vim', {
    \ 'autoload' : {
    \   'commands' : [
    \     'BenchVimrc'
    \   ]},
    \ }
  " NeoBundleLazy 'mattn/calendar-vim'
  "NeoBundle 'mattn/excitetranslate-vim'
  NeoBundleLazy 'mattn/gist-vim', {
    \ 'autoload' : {
    \   'commands' : [
    \     'Gist'
    \   ]},
    \ }
  " NeoBundleLazy 'mattn/habatobi-vim', {
  "   \ 'autoload' : {
  "   \   'commands' : 'Habatobi',
  "   \ }}
  NeoBundleLazy 'mattn/httpstatus-vim', {
    \ 'autoload' : {
    \   'commands' : [
    \     'HttpStatus',
    \     'CtrlPHttpStatus',
    \   ],
    \   'unite_sources' : 'httpstatus',
    \ }}
  NeoBundleLazy 'mattn/jscomplete-vim', { 'autoload' : {
    \   'filetypes' : ['javascript']
    \ }}
  NeoBundle 'mattn/learn-vimscript'
  "NeoBundle 'mattn/sonictemplate-vim'
  "NeoBundle 'mattn/vdbi-vim'
  "NeoBundleLazy 'mattn/vim-metarw-simplenote'
  NeoBundle 'mattn/vim-textobj-url',
    \ { 'depends' : 'kana/vim-textobj-user' }
  NeoBundle 'mattn/webapi-vim'
  NeoBundleLazy 'mattn/wwwrenderer-vim'
  NeoBundle 'mattn/emmet-vim'
  NeoBundle 'mhinz/vim-startify'
  NeoBundle 'mhinz/vim-signify'
  "NeoBundle 'mileszs/ack.vim'
  "NeoBundle 'motemen/git-vim'
  "NeoBundle 'motemen/hatena-vim'
  NeoBundleLazy 'msanders/cocoa.vim'
  "NeoBundle 'msanders/snipmate.vim'
  NeoBundle 'nathanaelkane/vim-indent-guides'
  NeoBundle 'nelstrom/vim-markdown-folding'
  NeoBundleLazy 'nono/jquery.vim', { 'autoload' : {
    \   'filetypes' : ['jquery']
    \ }}
  NeoBundleLazy 'nosami/Omnisharp', {
    \ 'autoload' : {
    \   'filetypes' : ['cs']
    \ },
    \ 'build' : {
    \   'windows': 'MSBuild.exe server/OmniSharp.sln /p:Platform="Any CPU"',
    \   'mac': 'xbuild server/OmniSharp.sln',
    \   'unix': 'xbuild server/OmniSharp.sln',
    \ }}
  NeoBundle 'osyo-manga/vim-anzu'
  NeoBundleLazy 'osyo-manga/vim-jplus', {
    \ 'autoload' : {
    \   'mappings' : [
    \     '<Plug>(jplus-getchar)',
    \     '<Plug>(jplus-getchar-with-space)',
    \     '<Plug>(jplus-input)',
    \     '<Plug>(jplus-input-with-space)',
    \   ],
    \ }}
  NeoBundleLazy 'osyo-manga/vim-over', {
    \ 'autoload' : {
    \   'commands' : [
    \     'OverCommandLine',
    \   ]},
    \ }
  NeoBundleLazy 'osyo-manga/vim-pronamachang', {
    \ 'depends' : [
    \   'Shougo/vimproc.vim',
    \   'osyo-manga/vim-sound',
    \ ],
    \ 'autoload' : {
    \   'commands' : 'PronamachangSay',
    \   'unite_sources' : 'pronamachang',
    \ },
    \ }
  NeoBundle 'osyo-manga/vim-reanimate'
  NeoBundleLazy 'osyo-manga/vim-textobj-multiblock',
    \ { 'depends' : 'kana/vim-textobj-user' }
  NeoBundleLazy 'osyo-manga/unite-quickfix', { 'autoload' : {
    \ 'unite_sources' : 'quickfix',
    \ }}
  NeoBundleLazy 'osyo-manga/unite-filetype', { 'autoload' : {
    \ 'unite_sources' : 'filetype',
    \ }}
  " NeoBundleLazy 'othree/eregex.vim'
  NeoBundleLazy 'pasela/unite-webcolorname', { 'autoload' : {
    \ 'unite_sources' : 'webcolorname',
    \ }}
  NeoBundleLazy 'phleet/vim-mercenary', {
    \ 'autoload' : {
    \   'commands' : [
    \     'HGblame',
    \     'HGshow',
    \     'HGcat',
    \     'HGdiff',
    \   ]},
    \ }
  NeoBundleLazy 'plasticboy/vim-markdown', { 'autoload' : {
    \ 'filetypes' : ['markdown', 'mkd']
    \ }}
  NeoBundle 'rbtnn/puyo.vim', {
    \ 'autoload' : {
    \   'commands' : [
    \     'Puyo',
    \   ]},
    \ }
  NeoBundleLazy 'rbtnn/vimconsole.vim', {
    \ 'autoload' : {
    \   'commands' : [
    \     'VimConsoleRedraw',
    \     'VimConsoleClear',
    \     'VimConsoleToggle',
    \     'VimConsoleDump',
    \     'VimConsole',
    \     'VimConsoleLog',
    \     'VimConsoleError',
    \     'VimConsoleWarn',
    \   ]},
    \ }
  NeoBundleLazy 'reinh/vim-makegreen'
  NeoBundleLazy 'rhysd/accelerated-jk'
  NeoBundleLazy 'rhysd/clever-f.vim', 'm@ster'
  " NeoBundle 'rhysd/vim-textobj-word-column'
  NeoBundleLazy 'rking/ag.vim'
  NeoBundle 'rphillips/vim-zoomwin'
  "NeoBundle 'scrooloose/nerdcommenter'
  NeoBundleLazy 'scrooloose/nerdtree', {
    \ 'autoload' : {
    \   'commands' : [
    \     'NERDTreeToggle',
    \   ]},
    \ }
  NeoBundle 'scrooloose/syntastic'
  NeoBundle 'sgur/vim-textobj-parameter',
    \ { 'depends' : 'kana/vim-textobj-user' }
  NeoBundleLazy 'sgur/unite-everything', { 'autoload' : {
    \ 'unite_sources' : 'everything',
    \ }}
  NeoBundleLazy 'sgur/unite-qf', { 'autoload' : {
    \ 'unite_sources' : 'qf',
    \ }}
  "NeoBundle 'sjl/clam.vim'
  NeoBundleLazy 'sjl/gundo.vim', {
    \ 'autoload' : {
    \   'commands' : [
    \     'GundoToggle',
    \   ]},
    \ }
  "NeoBundle 'sjl/splice.vim'
  "NeoBundle 'sjl/vitality.vim'
  NeoBundle 'skammer/vim-css-color'
  NeoBundleLazy 'skwp/vim-rspec', { 'autoload' : {
    \   'filetypes' : ['ruby', 'eruby', 'haml'],
    \ }}
  NeoBundleLazy 'supermomonga/thingspast.vim'
  NeoBundleLazy 'spolu/dwm.vim'
  NeoBundleLazy 'szw/vim-ctrlspace'
  NeoBundle 't9md/vim-quickhl'
  NeoBundleLazy 't9md/vim-smalls'
  NeoBundle 't9md/vim-surround_custom_mapping'
  "NeoBundle 't9md/vim-textmanip'
  "NeoBundle 't9md/vim-underlinetag'
  "NeoBundleLazy 't9md/vim-unite-ack',
    "\ { 'depends' : 'Shougo/unite.vim' }
  " NeoBundleLazy 'taichouchou2/unite-rails_best_practices', { 'autoload' : {
  "   \ 'unite_sources' : 'rails_best_practices',
  "   \ }}
  NeoBundleLazy 'taka84u9/vim-ref-ri', {
    \ 'autoload' : {
    \   'filetypes' : ['ruby', 'eruby', 'haml'],
    \   'unite_sources' : 'ref/ri',
    \ }}
  "NeoBundle 'taku-o/vim-toggle'
  "NeoBundle 'taku-o/vis-vim'
  NeoBundleLazy 'tejr/nextag'
  NeoBundle 'terryma/vim-expand-region'
  " NeoBundle 'terryma/vim-multiple-cursors'
  NeoBundle 'thinca/vim-ambicmd'
  NeoBundleLazy 'thinca/vim-fontzoom', {
    \ 'gui' : 1,
    \ 'autoload' : {
    \  'mappings' : [
    \   ['n', '<Plug>(fontzoom-larger)'],
    \   ['n', '<Plug>(fontzoom-smaller)']]
    \ }}
  NeoBundleLazy 'thinca/vim-github', {
    \ 'autoload' : {
    \   'commands' : [
    \     'Github',
    \   ]},
    \ }
  NeoBundle 'thinca/vim-openbuf'
  NeoBundleLazy 'thinca/vim-portal'
  NeoBundle 'thinca/vim-poslist'
  NeoBundleLazy 'thinca/vim-prettyprint', {
    \ 'autoload' : {
    \   'commands' : [
    \     'PP',
    \   ]},
    \ }
  NeoBundle 'thinca/vim-qfreplace'
  NeoBundleLazy 'thinca/vim-quickrun', {
    \ 'autoload' : {
    \   'mappings' : [
    \     ['nxo', '<Plug>(quickrun)']
    \   ],
    \   'commands' : [
    \     'QuickRun',
    \   ]},
    \ }
  NeoBundle 'thinca/vim-ref', '', 'default'
  call neobundle#config('vim-ref',{
    \ 'lazy' : 1,
    \ 'autoload' : {
    \   'commands' : [{ 'name' : 'Ref',
    \                   'complete' : 'customlist,ref#complete'}],
    \   'unite_sources' : ['ref'],
    \ }})
  NeoBundleLazy 'thinca/vim-scouter', {
    \ 'autoload' : {
    \   'commands' : [
    \     'Scouter',
    \   ]},
    \ }
  NeoBundle 'thinca/vim-singleton'
  "NeoBundle 'thinca/vim-template'
  NeoBundle 'thinca/vim-textobj-comment',
    \ { 'depends' : 'kana/vim-textobj-user' }
  NeoBundle 'thinca/vim-textobj-between',
    \ { 'depends' : 'kana/vim-textobj-user' }
  NeoBundleLazy 'thinca/vim-unite-history', { 'autoload' : {
    \ 'unite_sources' : ['history/command', 'history/search'],
    \ }}
  NeoBundle 'thinca/vim-visualstar'
  NeoBundleLazy 'tommcdo/vim-exchange'
  "NeoBundle 'tpope/vim-abolish'
  " NeoBundle 'tpope/vim-capslock'
  NeoBundle 'tpope/vim-commentary'
  "NeoBundle 'tpope/vim-eunuch'
  NeoBundle 'tpope/vim-endwise'
  NeoBundle 'tpope/vim-fugitive'
  "NeoBundle 'tpope/vim-markdown'
  NeoBundle 'tpope/vim-rails'
  NeoBundle 'tpope/vim-rbenv'
  NeoBundle 'tpope/vim-repeat'
  "NeoBundle 'tpope/vim-rvm'
  NeoBundle 'tpope/vim-surround'
  "NeoBundle 'tpope/vim-speeddating'
  "NeoBundle 'tpope/vim-unimpaired'
  NeoBundleLazy 'tsukkee/lingr-vim', {
    \ 'autoload' : {
    \   'commands' : [
    \     'LingrLaunch',
    \   ]},
    \ }
  NeoBundleLazy 'tsukkee/unite-tag', { 'autoload' : {
    \ 'unite_sources' : 'tag',
    \ }}
  NeoBundleLazy 'tyru/capture.vim', {
    \ 'autoload' : {
    \   'commands' : [
    \     'Capture',
    \   ]},
    \ }
  "NeoBundle 'tyru/caw.vim'
  "NeoBundle 'tyru/current-func-info.vim'
  "NeoBundle 'tyru/emap.vim'
  "NeoBundle 'tyru/eskk.vim'
  NeoBundleLazy 'tyru/nextfile.vim', {
    \ 'autoload' : {
    \   'mappings' : [
    \     ['n', '<Plug>(nextfile-next)'],
    \     ['n', '<Plug>(nextfile-previous)'],
    \   ]},
    \ }
  "NeoBundle 'tyru/operator-camelize.vim'
    "\ { 'depends' : 'kana/vim-operator-user' }
  NeoBundle 'tyru/open-browser.vim', {
    \ 'autoload' : {
    \   'mappings' : '<Plug>(openbrowser-smart-search)',
    \   'commands' : [
    \     'OpenBrowserSmartSearch',
    \     'OpenBrowser',
    \   ]},
    \ }
  NeoBundleLazy 'tyru/operator-html-escape.vim',
    \ { 'depends' : 'kana/vim-operator-user' }
  "NeoBundleLazy 'tyru/operator-reverse.vim',
    "\ { 'depends' : 'kana/vim-operator-user' }
  "NeoBundleLazy 'tyru/operator-star.vim',
    "\ { 'depends' : 'kana/vim-operator-user' }
  NeoBundleLazy 'tyru/restart.vim', {
    \ 'gui' : 1,
    \ 'autoload' : {
    \   'commands' : [
    \     'Restart',
    \   ]},
    \ }
  "NeoBundle 'tyru/vim-altercmd'
  NeoBundleLazy 'tyru/winmove.vim', { 'autoload' : {
    \ 'gui' : 1,
    \ 'mappings' : [
    \   ['n', '<Plug>(winmove-up)'],
    \   ['n', '<Plug>(winmove-down)'],
    \   ['n', '<Plug>(winmove-left)'],
    \   ['n', '<Plug>(winmove-right)']],
    \ }}
  "NeoBundle 'ujihisa/neco-look',
  "  \ { 'depends' : 'Shougo/neocomplcache' }
  NeoBundleLazy 'ujihisa/unite-colorscheme', { 'autoload' : {
    \ 'unite_sources' : 'colorscheme',
    \ }}
  NeoBundleLazy 'ujihisa/unite-font', { 'autoload' : {
    \ 'unite_sources' : 'font',
    \ }}
  NeoBundleLazy 'ujihisa/unite-locate', { 'autoload' : {
    \ 'unite_sources' : 'locate',
    \ }}
  NeoBundleLazy 'vexxor/kwbd.vim', {
    \ 'autoload' : {
    \   'commands' : [
    \     'Kwbd',
    \   ]},
    \ }
  "NeoBundleLazy 'vim-jp/autofmt', { 'autoload' : {
    "\ 'mappings' : [['x', 'gq']],
    "\ }}
  " NeoBundle 'vim-jp/vital.vim'
  NeoBundleLazy 'vim-ruby/vim-ruby', { 'autoload' : {
    \ 'mappings' : '<Plug>(ref-keyword)',
    \ 'filetypes' : ['ruby', 'eruby', 'haml'],
    \ }}
  NeoBundleLazy 'vimtaku/vim-textobj-sigil', {
    \ 'depends' : 'kana/vim-textobj-user',
    \ 'autoload' : {
    \   'filetypes' : 'perl',
    \ }}
  "NeoBundle 'vimtaku/vim-textobj-keyvalue',
    "\ { 'depends' : 'kana/vim-textobj-user' }
  "NeoBundle 'xolox/vim-easytags'
  NeoBundleLazy 'xolox/vim-misc'
  NeoBundleLazy 'xolox/vim-notes'
  "NeoBundle 'xolox/vim-session'
  NeoBundleLazy 'xuhdev/SingleCompile'
  NeoBundleLazy 'yko/mojo.vim', { 'autoload' : {
    \   'filetypes' : 'perl',
    \ }}
  "NeoBundle 'ynkdir/vim-remote'
  "NeoBundle 'yuratomo/w3m.vim'
  NeoBundleLazy 'zhaocai/unite-scriptnames', { 'autoload' : {
    \ 'unite_sources' : 'scriptnames',
    \ }}
  NeoBundle 'deris/columnjump'
  NeoBundle 'deris/vim-fitcolumn'
  NeoBundle 'deris/parajump'
  NeoBundle 'deris/vim-rengbang'
  NeoBundle 'deris/vim-pasta'
  NeoBundle 'deris/vim-textobj-enclosedsyntax',
    \ { 'depends' : 'kana/vim-textobj-user' }
  "NeoBundle 'deris/vim-loadafterft'
  NeoBundle 'deris/vim-textobj-headwordofline',
    \ { 'depends' : 'kana/vim-textobj-user' }

  " vim-scripts repos
  "NeoBundle 'Align'
  "NeoBundle 'CD.vim'
  "NeoBundle 'Conque-Shell'
  "NeoBundle 'DirDiff.vim'
  "NeoBundle 'DrawIt'
  "NeoBundle 'FuzzyFinder'
  NeoBundleLazy 'HybridText', { 'autoload' : {
    \ 'filetypes' : 'hybrid',
    \ }}
  "NeoBundle 'JSON.vim'
  NeoBundle 'L9'
  "NeoBundle 'Mark'
  "NeoBundle 'QuickBuf'
  "NeoBundle 'QFixHowm'
  "NeoBundle 'Source-Explorer-srcexpl.vim'
  "NeoBundle 'Toggle'
  NeoBundleLazy 'UnconditionalPaste'
  "NeoBundle 'ViewOutput'
  "NeoBundle 'YankRing.vim' "あまり使わないのとkeymap設定で悪さをするので削除
  "NeoBundle 'a.vim'
  "NeoBundle 'bufexplorer.zip'
  "NeoBundle 'closetag.vim'
  "NeoBundleLazy 'copypath.vim'
  NeoBundleLazy 'dbext.vim'
  "NeoBundle 'errormarker.vim'
  "NeoBundle 'grep.vim'
  NeoBundle 'gtags.vim'
  NeoBundle 'matchit.zip'
  "NeoBundle 'monday'
  "NeoBundle 'perl-support.vim'
  NeoBundleLazy 'project.tar.gz'
  "NeoBundle 'qtmplsel.vim'
  "NeoBundleLazy 'renamer.vim'
  "NeoBundle 'statusline.vim'
  NeoBundleLazy 'taglist.vim', {
    \ 'autoload' : {
    \   'commands' : [
    \     'TlistToggle',
    \   ]},
    \ }
  "NeoBundle 'toggle_words.vim'
  "NeoBundle 'trinity.vim'
  "NeoBundle 'vcscommand.vim'
  NeoBundleLazy 'vimwiki'

  " color scheme
  NeoBundleLazy 'altercation/vim-colors-solarized'
  NeoBundle 'croaker/mustang-vim'
  NeoBundle 'deris/molokai'
  NeoBundle 'deris/vim-wombat'
  NeoBundleLazy 'jnurmine/Zenburn'
  NeoBundleLazy 'newspaper.vim'

  " 日本語help
  NeoBundle 'vim-jp/vimdoc-ja'

  " Installation check.
  NeoBundleCheck
endif
" }}}

filetype plugin indent on

if s:bundled('vim-singleton')
  if has('clientserver')
    call singleton#enable()
  endif
endif

"---------------------------------------------------------------------------
" オプションの設定:{{{2

" 構文ハイライト有効化
syntax enable

set ignorecase
set smartcase
set incsearch
set hlsearch

set tabstop=4
set expandtab
set autoindent
set backspace=indent,eol,start
set nowrapscan
set showmatch
set matchpairs+=<:>
set wildmenu
set wildmode=longest,full
set wildignore=.git,.hg,.svn
set wildignore+=*.jpg,*.jpeg,*.bmp,*.gif,*.png
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.so,*.out,*.class
set wildignore+=*.swp,*.swo,*.swn
set wildignore+=*.DS_Store
" 日本語整形スクリプト(by. 西岡拓洋さん)用の設定
let format_allow_over_tw = 1 " ぶら下り可能幅
set shiftwidth=4
set smartindent
set smarttab
set whichwrap=b,s,h,l,<,>,[,]
set hidden
set textwidth=0
set formatoptions-=t
set formatoptions-=c
set formatoptions-=r
set formatoptions-=o
set formatoptions-=v
set formatoptions+=l
set number
set ruler
set list
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<,eol:<
set t_Co=256
set nrformats=hex
set winaltkeys=no
set visualbell
set noequalalways

set nowrap
set laststatus=2
set cmdheight=2
set showcmd
set title
set lines=50
set showtabline=2
"set statusline=%t\ %y\ [%{&fenc}][%{&ff}]\ %m%r%w%h%=%l/%L\ %v\ %P
set previewheight=10
set helpheight=12
set virtualedit=block
set scrolloff=5
set backup

function! s:LetAndMkdir(variable, path) "{{{
  try
    if !isdirectory(a:path)
      call mkdir(a:path, 'p')
    endif
  catch
    echohl WarningMsg
    echom '[error]' . a:path . 'is exist and is not directory, but is file or something.'
    echohl None
  endtry

  execute printf("let %s = a:path", a:variable)
endfunction "}}}

call s:LetAndMkdir('&backupdir', $DOTVIM.'/backup')
if has('unix')
  set backupskip=/tmp/*,/private/tmp/*
endif
set swapfile
call s:LetAndMkdir('&directory', $DOTVIM.'/swap')
set history=2000
let &showbreak = '+++ '
set ttyfast
if has('persistent_undo')
  set undofile
  call s:LetAndMkdir('&undodir', $DOTVIM.'/undo')
endif

set tags=./tags;

let &termencoding = &encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932
set fileformats=unix,dos,mac

if exists('&ambiwidth')
  set ambiwidth=double
endif

if s:bundled('vim-wombat')
  colorscheme wombat
else
  colorscheme desert
endif

scriptencoding utf-8

if has('vim_starting') && has('unix')
  let $PATH=$PERLBREW_ROOT.'/bin:'.$PATH
  let s:my_perl_path = split(system('which perl'), '[\r\n]')[0]
  let s:my_perl_path = fnamemodify(s:my_perl_path, ':p:h')
  if s:my_perl_path =~ '^/'
    let $PATH=s:my_perl_path.':'.$PATH
  endif
endif

if has('win32')
  let g:my_win32_grep_path = 'C:/usr/local/bin/jvgrep.exe'

  if executable(g:my_win32_grep_path)
    let &grepprg = g:my_win32_grep_path . ' -n8 --enc utf-8,cp932,euc-jp'
  endif
elseif has('unix')
  if executable('ag')
    set grepprg=ag\ -a\ $*\ /dev/null
  endif
  "if executable('ack')
    "set grepprg=ack\ -a\ $*\ /dev/null
  "endif
endif

" 全角スペースを表示
augroup hilightIdegraphicSpace
  autocmd!
  autocmd VimEnter,ColorScheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
  autocmd Syntax * syntax match IdeographicSpace containedin=ALL /　/
augroup END

" vimdiff時のハイライト
augroup diffcolor
  autocmd!
  autocmd ColorScheme * hi DiffAdd    ctermfg=black ctermbg=2
  autocmd ColorScheme * hi DiffChange ctermfg=black ctermbg=3
  autocmd ColorScheme * hi DiffDelete ctermfg=black ctermbg=6
  autocmd ColorScheme * hi DiffText   ctermfg=black ctermbg=7
augroup END

" カーソルラインと行ラインを表示
augroup cursorsetting
  autocmd!
  autocmd BufWinEnter,WinEnter * setlocal cursorline cursorcolumn
  autocmd BufWinLeave,WinLeave * setlocal nocursorline nocursorcolumn
augroup END

" 自動的に現在編集中のファイルのカレントディレクトリに移動
augroup movecurrentdir
  autocmd!
  autocmd BufRead,BufEnter * lcd %:p:h
augroup END

" 親ディレクトリが存在していなければ作成するかどうか確認
augroup AutoMkdir
  autocmd!
  autocmd BufNewFile * call PromptAndMakeDirectory()
augroup END

function! PromptAndMakeDirectory()
  let dir = expand("<afile>:p:h")
  if !isdirectory(dir) && confirm("Create a new directory [".dir."]?", "&Yes\n&No") == 1
    call mkdir(dir, "p")
    " Reset fullpath of the buffer in order to avoid problems when using autochdir.
    file %
  endif
endfunction

" kaoriya版に添付されているプラグインの無効化
let plugin_autodate_disable  = 1
let plugin_cmdex_disable     = 1
let plugin_dicwin_disable    = 1
let plugin_format_disable    = 1
let plugin_hz_ja_disable     = 1
let plugin_scrnmode_disable  = 1
let plugin_verifyenc_disable = 1

" }}}

"---------------------------------------------------------------------------
" key map:{{{2

let mapleader = ","
let maplocalleader = ","

nnoremap \  ,

if has('mac')
  noremap ¥ \
  noremap \ ¥
endif

" Escのkeymap
noremap  <C-[> <C-c>
noremap! <C-[> <C-c>
noremap  <C-c> <C-[>
noremap! <C-c> <C-[>
noremap  <C-@> <ESC>
noremap! <C-@> <ESC>

inoremap jk <Esc>
if has('mac')
  " 誤タイプ防止の為
  inoremap <D-j>k <Esc>
  inoremap <D-j><D-k> <Esc>
endif

" switch j,k and gj,gk
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap gj j
nnoremap gk k
vnoremap gj j
vnoremap gk k

" key map ^,$ to <Space>h,l. Because ^ and $ is difficult to type and damage little finger!!!
noremap <Space>h ^
noremap <Space>l $

" same as above. but don't use noremap because want to map to matchit plugin
map <Space>n %

" move middle of current line.(not middle of screen)
nnoremap <silent> gm   :<C-u>call <SID>MoveMiddleOfLine()<CR>

function! s:MoveMiddleOfLine()
  let strwidth = strdisplaywidth(getline('.'))
  let winwidth  = winwidth(0)

  if strwidth < winwidth
    call cursor(0, col('$') / 2)
  else
    normal! gm
  endif
endfunction

" vimrc編集
if has('gui')
  nnoremap <silent> <Space>.   :<C-u>execute 'tab drop ' . escape(resolve($MYVIMRC), ' ')<CR>
  nnoremap <silent> <Space>g.  :<C-u>execute 'tab drop ' . escape(resolve($MYGVIMRC), ' ')<CR>
else
  nnoremap <silent> <Space>.   :<C-u>execute 'tabe ' . escape(resolve($MYVIMRC), ' ')<CR>
  nnoremap <silent> <Space>g.  :<C-u>execute 'tabe ' . escape(resolve($MYGVIMRC), ' ')<CR>
endif
nnoremap <silent> <Space>s.  :<C-u>source $MYVIMRC \| if has('gui_running') \| source $MYGVIMRC \| endif<CR>

" helpショートカット
nnoremap <C-h>      :<C-u>help<Space>
nnoremap <C-h><C-h> :<C-u>help<Space><C-r><C-w><CR>

" 最後に選択したテキストをOperator-pending modeで使用可能に
onoremap gv         :<C-u>normal! gv<CR>

" 最後に変更されたテキストを選択する
nnoremap gc         `[v`]
vnoremap gc         :<C-u>normal gc<CR>
onoremap gc         :<C-u>normal gc<CR>
" 最後に変更されたテキストに移動する
nnoremap gI `.zz


" 直近コピーしたテキストを貼り付け
nnoremap 'p  "0p

" Use more logical mapping (see :h Y)
nnoremap Y y$
" クリップボードからペースト
nnoremap <Space>p "*p
vnoremap <Space>p "*p
nnoremap <Space>P "*P
vnoremap <Space>P "*P
" クリップボードにヤンク
nnoremap <Space>y "*y
nnoremap <Space>Y "*y$
vnoremap <Space>y "*y
" クリップボードにヤンクして削除
nnoremap <Space>d "*d
nnoremap <Space>D "*d$
vnoremap <Space>d "*d

" 空行挿入(繰り返し対応)
nnoremap <silent> <Space>o   :<C-u>for i in range(1, v:count1) \| call append(line('.'),   '') \| endfor \| silent! call repeat#set("<Space>o", v:count1)<CR>
nnoremap <silent> <Space>O   :<C-u>for i in range(1, v:count1) \| call append(line('.')-1, '') \| endfor \| silent! call repeat#set("<Space>O", v:count1)<CR>
nnoremap <silent> <S-Space>O :<C-u>for i in range(1, v:count1) \| call append(line('.')-1, '') \| endfor \| silent! call repeat#set("<S-Space>O"), v:count1<CR>

" from ujihisa's vimrc
nnoremap <Space>I $i
nnoremap X ^x

";と:を入れ替え
nnoremap ; :
vnoremap ; :
nnoremap q; q:
vnoremap q; q:
nnoremap : ;
vnoremap : ;

" <Space>;で最後のコマンドライン繰り返し
nnoremap <Space>; @:

" <Leader>.で直前の@xを繰り返し
nnoremap <Leader>. @@

" .: repeats the last command on every line
vnoremap .  :normal .<CR>

" @: repeats macro on every line
" vnoremap @  :normal @

let reg_list = []
call extend(reg_list, range(char2nr('0'), char2nr('9')))
call extend(reg_list, range(char2nr('a'), char2nr('z')))
call extend(reg_list, ['"', '.', '=', '*', '+', ':', '@'])
for i in reg_list
  execute 'vnoremap @'.i . ' :normal @'.i.'<CR>'
endfor

" disable because this is dangerous key
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>

" Don't use Ex mode, use Q for formatting
nnoremap Q gq

" Sticky Shift if difficult to type key
inoremap <expr> ;  <SID>sticky_func()
cnoremap <expr> ;  <SID>sticky_func()
snoremap <expr> ;  <SID>sticky_func()

function! s:sticky_func()
  let l:sticky_table = {
    \ ',' : '<', '.' : '>', '/' : '?',
    \ '1' : '!', '2' : '@', '3' : '#', '4' : '$', '5' : '%',
    \ '6' : '^', '7' : '&', '8' : '*', '9' : '(', '0' : ')', '-' : '_', '=' : '+',
    \ ';' : ':', '[' : '{', ']' : '}', '`' : '~', "'" : "\"", '\' : '|',
    \ }
  let l:special_table = {
    \ "\<ESC>" : "\<ESC>", "\<Space>" : ';', "\<CR>" : ";\<CR>"
    \ }

  let l:key = nr2char(getchar())
  if l:key =~ '\l'
    return toupper(l:key)
  elseif has_key(l:sticky_table, l:key)
    return l:sticky_table[l:key]
  elseif has_key(l:special_table, l:key)
    return l:special_table[l:key]
  else
    return 0
  endif
endfunction


nnoremap <silent><expr> r   <SID>sticky_with_replacemode(0)
nnoremap <silent><expr> gr  <SID>sticky_with_replacemode(1)

function! s:sticky_with_replacemode(gr)
  let l:gr = (a:gr ? 'gr' : 'r')

  let l:key = nr2char(getchar())
  if l:key == ';'
    return l:gr . s:sticky_func()
  else
    return l:gr . l:key
  endif
endfunction

" use <C-q> instead of @
nnoremap <C-q> @
nnoremap <C-q><C-q> @@

" map w to iw in motion. Because iw is commonly-used key and don't use w in motion.
onoremap w iw
onoremap W iW

" text-objectを割り当て
onoremap aa  a>
vnoremap aa  a>
onoremap ia  i>
vnoremap ia  i>

onoremap ar  a]
vnoremap ar  a]
onoremap ir  i]
vnoremap ir  i]

onoremap ad  a"
vnoremap ad  a"
onoremap id  i"
vnoremap id  i"

" key mapping強制ギブス
onoremap a>  <Esc>
vnoremap a>  <Nop>
onoremap i>  <Esc>
vnoremap i>  <Nop>
onoremap a<  <Esc>
vnoremap a<  <Nop>
onoremap i<  <Esc>
vnoremap i<  <Nop>

onoremap a]  <Esc>
vnoremap a]  <Nop>
onoremap i]  <Esc>
vnoremap i]  <Nop>
onoremap a[  <Esc>
vnoremap a[  <Nop>
onoremap i[  <Esc>
vnoremap i[  <Nop>

onoremap a"  <Esc>
vnoremap a"  <Nop>
onoremap i"  <Esc>
vnoremap i"  <Nop>

" exコマンド
nnoremap <Space>w :<C-u>update<CR>
nnoremap <Space>q :<C-u>SafeQuit<CR>
nnoremap <Space>Q :<C-u>SafeQuit!<CR>
nnoremap <S-Space>Q :<C-u>SafeQuit!<CR>
nnoremap <Space>bd :<C-u>bwipeout<CR>
nnoremap <Space>bD :<C-u>bwipeout!<CR>
nnoremap <Space>bb :<C-u>buffer #<CR>

function! s:safeQuit(bang)
  " 最後のタブ&最後のウィンドウでなければ終了
  if !(tabpagenr('$') == 1 && winnr('$') == 1)
    execute 'quit'.a:bang
    return
  endif

  " 終了するかどうか確認
  echohl WarningMsg
  let l:input = input('Are you sure to quit vim?[y/n]: ')
  echohl None
  redraw!

  if l:input ==? 'y'
    execute 'quit'.a:bang
  endif
endfunction

command! -bang SafeQuit call s:safeQuit('<bang>')

" 仮想置換モード
nnoremap R gR

" win間移動
nnoremap <M-h>   <C-w>h
nnoremap <M-j>   <C-w>j
nnoremap <M-k>   <C-w>k
nnoremap <M-l>   <C-w>l
nnoremap <M-H>   <C-w>H
nnoremap <M-J>   <C-w>J
nnoremap <M-K>   <C-w>K
nnoremap <M-L>   <C-w>L

if has('mac')
  nnoremap <D-h>   <C-w>h
  nnoremap <D-j>   <C-w>j
  nnoremap <D-k>   <C-w>k
  nnoremap <D-l>   <C-w>l
  nnoremap <D-H>   <C-w>H
  nnoremap <D-J>   <C-w>J
  nnoremap <D-K>   <C-w>K
  nnoremap <D-L>   <C-w>L
endif

" Search the word nearest to the cursor in new window.
nnoremap <C-w>*  <C-w>s*
nnoremap <C-w>#  <C-w>s#

" command mode
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>
cnoremap <C-a> <Home>
cnoremap <expr> <C-d> (getcmdpos()==strlen(getcmdline())+1 ? "\<C-d>" : "\<Del>")
cnoremap <C-e> <END>
cnoremap <C-h> <BS>
" カーソル位置にかかわらず全部消す
cnoremap <C-u> <C-e><C-u>

" コマンドラインモードでコマンドラインウィンドウを開く
cnoremap <C-v> <C-f>a

" カーソル下のlineを挿入
cnoremap <expr> <C-r><C-l>   matchstr(getline("."), '[^ \t:][^\r\n]*')

" ASCII keyboardで打ちやすいように
cnoremap <C-r>' <C-r>"

" command modeでの自動エスケープ
cnoremap <expr> /  getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ?  getcmdtype() == '?' ? '\?' : '?'

" expand directory of active file
cnoremap <expr> %%  getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" 置換の自動入力
nnoremap gs  :<C-u>%s///g<Left><Left><Left>
vnoremap gs  :s///g<Left><Left><Left>
nnoremap gS  :<C-u>%s///gc<Left><Left><Left>
vnoremap gS  :s///gc<Left><Left><Left>

" vim diffのkeymap
nnoremap dp dp:<C-u>diffupdate<CR>]czz
nnoremap do do:<C-u>diffupdate<CR>]czz
vnoremap <Leader>dp :diffput<CR>:<C-u>diffupdate<CR>zz
vnoremap <Leader>do :diffget<CR>:<C-u>diffupdate<CR>zz
nnoremap du :<C-u>diffupdate<CR>
nnoremap dy [czz
nnoremap dm ]czz
vnoremap <Leader>dy [czz
vnoremap <Leader>dm ]czz

" insert mode
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <M-b> <S-Left>
inoremap <M-f> <S-Right>
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$
inoremap <C-h> <BS>
inoremap <C-d> <Del>
"inoremap <C-k> <C-o>C
"inoremap <C-y> <C-o>p
" undoできるC-w,C-u
inoremap <C-w> <C-g>u<C-w>
inoremap <C-u> <C-g>u<C-u>

inoremap <S-Enter> <C-o>O

" ハイライトを消す
nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>
nnoremap <silent> <C-c><C-c> :<C-u>nohlsearch<CR>
nnoremap <silent> <C-[><C-[> :<C-u>nohlsearch<CR>
nnoremap <silent> <C-@><C-@> :<C-u>nohlsearch<CR>

" 検索方向が変わってもnは下、Nは上に移動できるように対応
nnoremap <expr> n <SID>search_forward_p() ? 'nzv' : 'Nzv'
nnoremap <expr> N <SID>search_forward_p() ? 'Nzv' : 'nzv'
vnoremap <expr> n <SID>search_forward_p() ? 'nzv' : 'Nzv'
vnoremap <expr> N <SID>search_forward_p() ? 'Nzv' : 'nzv'
onoremap <expr> n <SID>search_forward_p() ? 'n' : 'N'
onoremap <expr> N <SID>search_forward_p() ? 'N' : 'n'

function! s:search_forward_p()
  return exists('v:searchforward') ? v:searchforward : 1
endfunction

" scrolloffが設定されていてもスクリーンの最上行に移動する
if &scrolloff > 0
  nnoremap <expr> H 'H' . &scrolloff . 'kzvzz'
  nnoremap <expr> L 'L' . &scrolloff . 'jzvzz'
endif

" 仮想編集の変更
nnoremap <Space>va  :<C-u>setlocal virtualedit=all<CR>:setlocal virtualedit?<CR>
nnoremap <Space>vb  :<C-u>setlocal virtualedit=block<CR>:setlocal virtualedit?<CR>
nnoremap <Space>vv  :<C-u>let &virtualedit=(&ve == "block" ? "all" : "block")<CR>:setlocal virtualedit?<CR>

" very magic（正規表現をエスケープしなくてよくなる）
noremap /   /\v
noremap ?   ?\v

" カーソル下のウィンドウを編集（数字が付いていればその行へ）
noremap gf gF

" tab mode
nnoremap [tabmode]   <Nop>
nmap     t           [tabmode]

nnoremap [tabmode]t  :<C-u>tabnew<CR>
nnoremap [tabmode]d  :<C-u>tabclose<CR>

nnoremap <silent> <C-p> gT
nnoremap <silent> <C-n> gt

" tag jump
nnoremap [tagjump]    <Nop>
nmap     <Space>t     [tagjump]

nnoremap [tagjump]t   <C-]>          " 「飛ぶ」
nnoremap [tagjump]j   :<C-u>tag<CR>  " 「進む」
nnoremap [tagjump]k   :<C-u>pop<CR>  " 「戻る」
nnoremap [tagjump]l   :<C-u>tags<CR> " 履歴一覧

"--------------------
" Function: Open tag under cursor in new tab
" Source:   http://stackoverflow.com/questions/563616/vimctags-tips-and-tricks
"--------------------
nnoremap [tagjump]n   :<C-u>tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" filetype
nnoremap [filetype]    <Nop>
nmap     <Leader>t     [filetype]

nnoremap [filetype]p   :<C-u>set filetype=perl<CR>
nnoremap [filetype]v   :<C-u>set filetype=vim<CR>
nnoremap [filetype]c   :<C-u>set filetype=c<CR>
nnoremap [filetype]o   :<C-u>set filetype=objc<CR>
nnoremap [filetype]j   :<C-u>set filetype=java<CR>
nnoremap [filetype]s   :<C-u>set filetype=shell<CR>
nnoremap [filetype]r   :<C-u>set filetype=ruby<CR>
nnoremap [filetype]a   :<C-u>set filetype=javascript<CR>
nnoremap [filetype]h   :<C-u>set filetype=html<CR>
nnoremap [filetype]x   :<C-u>set filetype=xml<CR>
nnoremap [filetype]d   :<C-u>set filetype=diff<CR>
nnoremap [filetype]l   :<C-u>set filetype=scala<CR>

command! -nargs=1 -complete=filetype FileType execute "set filetype=".<q-args>

" kana's useful tab function {{{
function! s:move_window_into_tab_page(target_tabpagenr)
  " Move the current window into a:target_tabpagenr.
  " If a:target_tabpagenr is 0, move into new tab page.
  if a:target_tabpagenr < 0  " ignore invalid number.
    return
  endif
  let original_tabnr = tabpagenr()
  let target_bufnr = bufnr('')
  let window_view = winsaveview()

  if a:target_tabpagenr == 0
    tabnew
    tabmove  " Move new tabpage at the last.
    execute target_bufnr 'buffer'
    let target_tabpagenr = tabpagenr()
  else
    execute a:target_tabpagenr 'tabnext'
    let target_tabpagenr = a:target_tabpagenr
    topleft new  " FIXME: be customizable?
    execute target_bufnr 'buffer'
  endif
  call winrestview(window_view)

  execute original_tabnr 'tabnext'
  if 1 < winnr('$')
    close
  else
    enew
  endif

  execute target_tabpagenr 'tabnext'
endfunction " }}}

" move current buffer into a new tab.
nnoremap <silent> <C-w><C-t> :<C-u>call <SID>move_window_into_tab_page(0)<CR>
nnoremap <silent> <C-w>t     :<C-u>call <SID>move_window_into_tab_page(0)<CR>

" change expandtab booster
nnoremap t2 :<C-U>setlocal expandtab shiftwidth=2 tabstop=2<CR>
nnoremap t4 :<C-U>setlocal noexpandtab shiftwidth=4 tabstop=4<CR>
nnoremap <Space>t2 :<C-U>setlocal expandtab shiftwidth=2 tabstop=2 nolist<CR>
nnoremap <Space>t4 :<C-U>setlocal noexpandtab shiftwidth=4 tabstop=4 nolist<CR>

" 差分モードを終了する
function! s:DiffOff()
  diffoff!
  set nowrap
endfunction

command! DiffOff call s:DiffOff()

" Google Chromeで開く
function! s:GoogleChrome(...)
  if has('mac')
    let l:cmd = "silent !open -a Google\\ Chrome "
  elseif has('win32')
    let l:cmd = "silent !start google\\ chrome "
  else
    return
  endif
  if a:0 == 0
    execute l:cmd . "%"
  else
    execute l:cmd . a:1
  endif
endfunction

command! -nargs=? GoogleChrome call s:GoogleChrome(<f-args>)

" 検索文字列をレジスタでグローバル置換
nnoremap <silent> <Space>rs :<C-u>execute '%substitute//' . escape(getreg(), '/\') . '/g'

" 縦に連番を入力する
nnoremap <silent> <space>co :ContinuousNumber <c-a><cr>
vnoremap <silent> <space>co :ContinuousNumber <c-a><cr>
command! -count -nargs=1 ContinuousNumber let c = col('.')|for n in range(1, <count>?<count>-line('.'):1)|exec 'normal! j' . n . <q-args>|call cursor('.', c)|endfor

" from ujihisa's vimrc
command! -count=1 -nargs=0 GoToTheLine silent execute getpos('.')[1][:-len(v:count)-1] . v:count
"nnoremap <silent> gl :GoToTheLine<Cr>

" If unite-quickfix is bundled use unite-quickfix, otherwise use built-in quickfix window
function s:OpenQuickFix()
  if s:bundled('unite.vim') && s:bundled('unite-quickfix')
    Unite -no-quit -direction=botright quickfix
  else
    copen
  endif
endfunction

" grep
function! s:Grep(pattern, target)
  execute 'grep ' . a:pattern . ' ' . a:target
  call s:OpenQuickFix()
endfunction

command! -nargs=+ Grep call s:Grep(<f-args>)

" Count Char
function! s:CountChar(c)
  let line = getline('.')
  let match = stridx(line, a:c)
  let cnt = 0
  while match != -1
    let cnt = cnt + 1
    let match = stridx(line, a:c, match + 1)
  endwhile

  echo cnt . " '" . a:c . "' in current line."
endfunction

command! -nargs=1 CountChar call s:CountChar(<f-args>)

function s:EchoSynName()
  let synlist = []
  for id in synstack(line("."), col("."))
    call add(synlist, synIDattr(id, "name"))
  endfor
  echo synlist
endfunction

command! -nargs=0 EchoSynName call s:EchoSynName()

" visualモードで最後に選択したテキストを%sで指定してコマンドを実行する {{{
function! ExecuteWithSelectedText(command)
  if a:command !~? '%s'
    return
  endif

  let reg = '"'
  let [save_reg, save_type] = [getreg(reg), getregtype(reg)]
  normal! gvy
  let selectedText = @"
  call setreg(reg, save_reg, save_type)
  if selectedText == ''
    return
  endif

  execute printf(a:command, selectedText)
endfunction
" }}}

command -nargs=? -range=% ExtractMatches <line1>,<line2>call s:extract_matches(<f-args>)

function! s:extract_matches(...) range
  let s:pattern = get(a:000, 0, @/)

  let s:result = filter(getline(a:firstline, a:lastline), 'v:val =~# s:pattern')

  new
  setlocal buftype=nofile
  call setline(1, s:result)
endfunction

" }}}

"---------------------------------------------------------------------------
" Command {{{2
command! Utf8 e ++enc=utf-8
command! Euc e ++enc=euc-jp
command! Sjis e ++enc=cp932
command! Jis e ++enc=iso-2022-jp
command! WUtf8 w ++enc=utf-8 | e
command! WEuc w ++enc=euc-jp | e
command! WSjis w ++enc=cp932 | e
command! WJis w ++enc=iso-2022-jp | e
" }}}

"---------------------------------------------------------------------------
" filetype {{{2

augroup commonfiletype
  autocmd!
  autocmd FileType * setlocal fo-=t fo-=c fo-=r fo-=o fo-=v fo+=l
  autocmd FileType * setlocal textwidth=0
  autocmd SourceCmd .vimrc setlocal fo-=t fo-=c fo-=r fo-=o fo-=v fo+=l
augroup END
augroup vimlang
  autocmd!
  autocmd FileType vim setlocal expandtab tabstop=2 shiftwidth=2 list
  autocmd FileType vim let g:vim_indent_cont = 2
augroup END
augroup makefile
  autocmd!
  autocmd FileType make setlocal noexpandtab list
augroup END
augroup clang
  autocmd!
  autocmd FileType c setlocal expandtab tabstop=2 shiftwidth=2 list
augroup END
augroup rubylang
  autocmd!
  autocmd FileType ruby setlocal expandtab tabstop=2 shiftwidth=2 list
augroup END
augroup perllang
  autocmd!
  autocmd BufRead,BufNewFile *.psgi setfiletype perl
  autocmd BufRead,BufNewFile *.t    setfiletype perl
  autocmd FileType perl setlocal expandtab tabstop=4 shiftwidth=4 list
  " perlの関数に飛ぶ
  autocmd FileType perl noremap <silent><buffer> ]]  m':<c-u>call search('^\s*sub\>', "W")<CR>
  autocmd FileType perl noremap <silent><buffer> [[  m':<c-u>call search('^\s*sub\>', "bW")<CR>
  autocmd FileType perl compiler perl
  "autocmd BufWritePost *.pl,*.pm silent make
augroup END
augroup htmlfile
  autocmd!
  autocmd FileType html,xhtml setlocal expandtab tabstop=2 shiftwidth=2 list
augroup END
augroup xmlfile
  autocmd!
  autocmd FileType xml setlocal expandtab tabstop=2 shiftwidth=2 list
augroup END
augroup jslang
  autocmd!
  autocmd FileType javascript setlocal expandtab tabstop=2 shiftwidth=2 list
augroup END
augroup iolang
  autocmd!
  autocmd BufRead,BufNewFile *.io setfiletype io
  autocmd FileType io setlocal expandtab tabstop=2 shiftwidth=2 list
augroup END
augroup scalalang
  autocmd!
  autocmd BufRead,BufNewFile *.scala setfiletype scala
  autocmd FileType scala setlocal expandtab tabstop=2 shiftwidth=2 list
augroup END
augroup zshlang
  autocmd!
  autocmd FileType zsh setlocal expandtab tabstop=2 shiftwidth=2 list
augroup END


" Objective-C
if has('mac')
  " for tablist.vim Objective-C
  let tlist_objc_settings='objc;P:protocols;i:interfaces;I:implementations;M:instance methods;C:implementation methods;Z:protocol methods'
  " for a.vim Objective-C
  let g:alternateExtensions_h = "m,mm,c,cpp"
  let g:alternateExtensions_m = "h"
  let g:alternateExtensions_mm = "h,hpp"
  " for Objective-C gfでジャンプできるように
  augroup objclang
    autocmd!
    autocmd FileType objc setlocal path=.;,/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS4.0.sdk/System/Library/Frameworks,/Developer/SDKs/MacOSX10.6.sdk/System/Library/Frameworks,,
    autocmd FileType objc setlocal include=^\s*#\s*import
    autocmd FileType objc setlocal includeexpr=substitute(v:fname,'\/','\.framework/Headers/','g')
    autocmd FileType objc setlocal makeprg=xcodebuild\ -activetarget\ -activeconfiguration
  augroup END
endif

" }}}

" }}}

"---------------------------------------------------------------------------
" plugins {{{1

"---------------------------------------------------------------------------
" for AndrewRadev/switch.vim {{{2
if s:bundled('switch.vim')
  let g:switch_custom_definitions = [
    \   ['true', 'false'],
    \ ]
  autocmd FileType vim let b:switch_custom_definitions = [
    \   {'\vhttps?://github.com/([^/]+)/([^/]+)%(\.git)?': '\1/\2'},
    \   ['NeoBundle', 'NeoBundleLazy'],
    \   {'\vlet\s+(%([gstb]:)?\a+)\s*[.+\-*/]?\=.*': 'unlet \1'},
    \   ['echo', 'echomsg'],
    \   ['if', 'elseif'],
    \   ['try', 'catch', 'finally'],
    \   {'\<\([nvxsoilc]\?\)noremap': '\1map'},
    \   {'\<\([nvxsoilc]\?\)map':     '\1noremap'},
    \ ]
  autocmd FileType markdown let b:switch_custom_definitions = [
    \   ['[ ]', '[x]'],
    \   ['#', '##', '###', '####', '#####'],
    \   { '\(\*\*\|__\)\(.*\)\1': '_\2_' },
    \   { '\(\*\|_\)\(.*\)\1': '__\2__' },
    \ ]

  nnoremap <Space>m  <Plug>(switch-next)
endif
" }}}

"---------------------------------------------------------------------------
" for LeafCage/yankround.vim {{{2
if s:bundled('yankround.vim')
  call submode#enter_with('yankround', 'n', 'r', '<Leader>p', '<Plug>(yankround-p)')
  call submode#enter_with('yankround', 'n', 'r', '<Leader>P', '<Plug>(yankround-P)')
  call submode#map('yankround', 'n', 'r', 'p', '<Plug>(yankround-prev)')
  call submode#map('yankround', 'n', 'r', 'n', '<Plug>(yankround-next)')
endif
" }}}

"---------------------------------------------------------------------------
" for Lokaltog/vim-easymotion {{{2
let g:EasyMotion_leader_key = ','
let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
let g:EasyMotion_do_shade = 1
augroup easymotioncolor
  autocmd!
  autocmd ColorScheme * hi EasyMotionTarget ctermbg=none ctermfg=green
  autocmd ColorScheme * hi EasyMotionShade  ctermbg=none ctermfg=blue
augroup END
" }}}

"---------------------------------------------------------------------------
" for Shougo/neocomplete {{{2
if s:bundled('neocomplete')
  " Disable AutoComplPop.
  let g:acp_enableAtStartup = 0
  " Use neocomplete.
  let g:neocomplete#enable_at_startup = 1
  " Use smartcase.
  let g:neocomplete#enable_smart_case = 1
  " Set minimum syntax keyword length.
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

  let g:neocomplete#auto_completion_start_length = 3
  let g:neocomplete#manual_completion_start_length = 3

  " Define dictionary.
  let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

  " Define keyword.
  if !exists('g:neocomplete#keyword_patterns')
      let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns['default'] = '\h\w*'

  " for neco-look
  let g:neocomplete#text_mode_filetypes = {
    \ 'markdown' : 1,
    \ 'mkd' : 1,
    \ }

  " Plugin key-mappings.
  inoremap <expr><C-g>  neocomplete#undo_completion()
  inoremap <expr><C-l>  neocomplete#complete_common_string()

  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h>  neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS>   neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y>  neocomplete#close_popup()

  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

  " Enable heavy omni completion.
  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif
  let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
  "autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
  let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
  let g:neocomplete#sources#omni#input_patterns.c = '\%(\.\|->\)\h\w*'
  let g:neocomplete#sources#omni#input_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
  let g:neocomplete#sources#omni#input_patterns.cs = '.*'
  " For perlomni.vim setting.
  " https://github.com/c9s/perlomni.vim
  "let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
endif
" }}}

"---------------------------------------------------------------------------
" for Shougo/neosnippet {{{2
if s:bundled('neosnippet')
  call s:LetAndMkdir('g:neosnippet#snippets_directory', $DOTVIM.'/snippets')

  " Plugin key-mappings.
  imap <C-k>     <Plug>(neosnippet_expand_or_jump)
  smap <C-k>     <Plug>(neosnippet_expand_or_jump)
  xmap <C-k>     <Plug>(neosnippet_expand_target)
  xmap <C-l>     <Plug>(neosnippet_start_unite_snippet_target)

  smap <C-e>     <Plug>(neosnippet_jump)

  nnoremap <Space>e  :<C-u>NeoSnippetEdit<Space>
  nnoremap <Space>ee :<C-u>NeoSnippetEdit<CR>

  " SuperTab like snippets behavior.
  "imap <expr><TAB> neosnippet#expandable() ?
  " \ "\<Plug>(neosnippet_expand_or_jump)"
  " \: pumvisible() ? "\<C-n>" : "\<TAB>"
  "smap <expr><TAB> neosnippet#expandable() ?
  " \ "\<Plug>(neosnippet_expand_or_jump)"
  " \: "\<TAB>"

  " For snippet_complete marker.
  if has('conceal')
    set conceallevel=2 concealcursor=i
  endif
  set completeopt-=preview

  augroup snippetlang
    autocmd!
    autocmd FileType snippet setlocal noexpandtab tabstop=4 shiftwidth=4 list
    autocmd FileType snippet setlocal foldmethod=expr
    autocmd FileType snippet setlocal foldexpr=getline(v:lnum)=~'^snippet'?'>1':getline(v:lnum)=~'^#'?0:getline(v:lnum+1)=~'^snippet'?'<1':'='
    autocmd FileType snippet setlocal foldtext=FoldTextOfSnippet()
  augroup END

  " snippetの折りたたみ用関数。snippet名とabbrを返す
  function! FoldTextOfSnippet()
    let snippet = matchstr(getline(v:foldstart), '^snippet\s\+\zs\S.*')
    let abbrstr = ''

    " snippetの定義の2行目から5行目まででabbrを探す
    for i in range(1, 4)
      if getline(v:foldstart+i) !~ '^\w'
        break
      endif
      if getline(v:foldstart+i) =~ '^abbr'
        let abbrstr = matchstr(getline(v:foldstart+i), '^abbr\s\+\zs\S.*')
        break
      endif
    endfor

    return printf('%- 30s', snippet) . abbrstr
  endfunction

endif
" }}}

"---------------------------------------------------------------------------
" for Shougo/unite.vim {{{2
if s:bundled('unite.vim')
  nnoremap [unite]    <Nop>
  nmap     <Space>u [unite]

  nnoremap <silent> [unite]c   :<C-u>UniteWithCurrentDir -buffer-name=files buffer file_mru bookmark file<CR>
  nnoremap <silent> [unite]b   :<C-u>Unite buffer<CR>
  " nnoremap <silent> [unite]r   :<C-u>Unite register<CR>
  nnoremap <silent> [unite]o   :<C-u>Unite outline<CR>
  nnoremap <silent> [unite]u   :<C-u>Unite file_mru<CR>
  nnoremap <silent> [unite]d   :<C-u>Unite directory_mru<CR>
  nnoremap <silent> [unite]k   :<C-u>Unite bookmark<CR>
  nnoremap <silent> [unite]s   :<C-u>Unite source<CR>
  nnoremap <silent> [unite]f   :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
  nnoremap <silent> [unite]g   :<C-u>call <SID>unite_grep_with_filetype()<CR>
  nnoremap <silent> [unite]h   :<C-u>Unite help<CR>
  nnoremap <silent> [unite];   :<C-u>Unite history/command<CR>
  nnoremap <silent> [unite]/   :<C-u>Unite history/search<CR>
  nnoremap <silent> [unite]y   :<C-u>Unite history/yank<CR>
  nnoremap <silent> [unite]a   :<C-u>UniteBookmarkAdd<CR>
  nnoremap <silent> [unite]n   :<C-u>Unite neobundle/install:!<CR>
  nnoremap <silent> [unite]e   :<C-u>Unite snippet<CR>
  nnoremap <silent> [unite]q   :<C-u>Unite quickfix<CR>
  nnoremap <silent> [unite]p   :<C-u>Unite ref/perldoc<CR>
  nnoremap <silent> [unite]m   :<C-u>Unite mapping<CR>
  nnoremap <silent> [unite]l   :<C-u>Unite colorscheme -auto-preview<CR>
  nnoremap <silent> [unite]r   :<C-u>UniteResume<CR>

  let s:target_ft = {
    \ 'c': '**/*.[ch]',
    \ 'pl': '**/*.pl',
    \ 'rb': '**/*.rb',
    \ }
  function! s:unite_grep_with_filetype() "{{{
    try
      if get(s:target_ft, &ft, '') != ''
        let pattern = s:input('Pattern: ')
        let pattern = pattern=='' ? expand('<cword>') : pattern
        execute 'Unite grep:' . s:target_ft[&ft] . ' -input=' . pattern
      else
        execute 'Unite grep'
      endif
    catch /Canceled/
    endtry
  endfunction "}}}

  function! s:input(...) abort
    new
    cmap <buffer> <esc> __CANCELED__<cr>
    let ret = call('input', a:000)
    bw!
    redraw
    if ret =~ '__CANCELED__$'
      throw "Canceled"
    endif
    echom ret
    return ret
  endfunction

  " Start insert.
  "let g:unite_enable_start_insert = 1

  autocmd FileType unite call s:unite_my_settings()
  function! s:unite_my_settings() "{{{
    nmap <buffer> <ESC>  <Plug>(unite_exit)
    nmap <buffer> <C-c>  <Plug>(unite_exit)
    imap <buffer> jk     <Plug>(unite_insert_leave)

    nmap <buffer> <Space>           <Nop>
    nmap <buffer> <Leader><Leader>  <Plug>(unite_toggle_mark_current_candidate)
    imap <buffer> <Leader><Leader>  <Plug>(unite_toggle_mark_current_candidate)
    vmap <buffer> <Leader><Leader>  <Plug>(unite_toggle_mark_selected_candidates)

    " <C-l>: manual neocomplete completion.
    inoremap <buffer> <C-l>  <C-x><C-u><C-p><Down>

    " action key mapping
    nnoremap <silent><buffer><expr> r     unite#do_action('replace')

    call unite#custom_default_action('directory', 'tabvimfiler')
    call unite#custom_default_action('directory_mru', 'tabvimfiler')

  endfunction "}}}

  let g:unite_source_file_mru_limit = 200
  let g:unite_cursor_line_highlight = 'TabLineSel'
  let g:unite_abbr_highlight = 'TabLine'
  let g:unite_winheight = 15
  let g:unite_source_file_mru_time_format = "%m/%d %H:%M "

  " For optimize.
  let g:unite_source_file_mru_filename_format = ''

  " For history/yank
  let g:unite_source_history_yank_enable = 1
  let g:unite_source_history_yank_limit = 100
  let g:unite_source_history_yank_file = $DOTVIM.'/history_yank'

  if has('win32')
    if executable(g:my_win32_grep_path)
      let g:unite_source_grep_command = g:my_win32_grep_path
      let g:unite_source_grep_recursive_opt = '-R'
      let g:unite_source_grep_default_opts = '-n --enc utf-8,cp932,euc-jp'
    endif
  elseif has('unix')
    if executable('ag')
      let g:unite_source_grep_command = 'ag'
      let g:unite_source_grep_recursive_opt = ''
      let g:unite_source_grep_default_opts = '--nocolor --nogroup --hidden --ignore-dir=.git'
    endif
  endif
  let g:unite_source_grep_max_candidates = 200

  " For unite-session.
  " Save session automatically.
  "let g:unite_source_session_enable_auto_save = 1
  " Load session automatically.
  "autocmd VimEnter * UniteSessionLoad

endif
" }}}

"---------------------------------------------------------------------------
" for Shougo/vimfiler {{{2
" File explorer like behavior.
if s:bundled('vimfiler')
  nnoremap [vimfiler]  <Nop>
  nmap     <Space>f  [vimfiler]

  nnoremap <silent> [vimfiler]f   :<C-u>VimFiler -buffer-name=explorer -split -simple -winwidth=35 -toggle -no-quit<CR>
  nnoremap <silent> [vimfiler]d   :<C-u>VimFilerTab -double -no-quit<CR>
  nnoremap <silent> [vimfiler]b   :<C-u>VimFiler -buffer-name=explorer -split -simple -winwidth=35 -toggle -no-quit -auto-cd $VIMBUNDLE<CR>

  let g:vimfiler_as_default_explorer = 1
  let g:vimfiler_enable_auto_cd = 1

  " Use trashbox.
  " Windows only and require latest vimproc.
  if has('win32')
    let g:unite_kind_file_use_trashbox = 1
  endif

  call s:LetAndMkdir('g:vimfiler_data_directory', $DOTVIM.'/.vimfiler')

  if has('mac')
    " Like Textmate icons.
    let g:vimfiler_tree_leaf_icon = ' '
    let g:vimfiler_tree_opened_icon = '▾'
    let g:vimfiler_tree_closed_icon = '▸'
    let g:vimfiler_file_icon = '-'
    let g:vimfiler_marked_file_icon = '*'
  else
    let g:vimfiler_tree_leaf_icon = ' '
    let g:vimfiler_tree_opened_icon = '-'
    let g:vimfiler_tree_closed_icon = '+'
    let g:vimfiler_file_icon = '-'
    let g:vimfiler_marked_file_icon = '*'
  endif

  autocmd FileType vimfiler call s:vimfiler_my_settings()
  function! s:vimfiler_my_settings() "{{{
    if has('gui')
      nnoremap <silent><buffer><expr> E  vimfiler#do_action('tabdrop')
    else
      nnoremap <silent><buffer><expr> E  vimfiler#do_action('tabopen')
    endif
    nnoremap <silent><buffer><expr> s  vimfiler#do_action('right')
    nnoremap <silent><buffer><expr> f  vimfiler#do_action('diff')
    nmap <buffer><expr> e vimfiler#smart_cursor_map(
      \  "\<Plug>(vimfiler_cd_file)",
      \  "\<Plug>(vimfiler_edit_file)")

    nmap <buffer> <Space>           <Nop>
    nmap <buffer> <Leader><Leader>  <Plug>(vimfiler_toggle_mark_current_line)
    vmap <buffer> <Leader><Leader>  <Plug>(vimfiler_toggle_mark_selected_lines)

  endfunction "}}}

endif
" }}}

"---------------------------------------------------------------------------
" for Shougo/vimshell {{{2
if s:bundled('vimshell')
  nnoremap <Leader>vv  :<C-u>tabnew<CR>:<C-u>VimShell<CR>
  let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
  let g:vimshell_enable_smart_case = 1

  if has('win32') || has('win64')
    " Display user name on Windows.
    let g:vimshell_prompt = $USERNAME."% "
  else
    " Display user name on Linux.
    let g:vimshell_prompt = $USER."% "
  endif

  " Initialize execute file list.
  let g:vimshell_execute_file_list = {}
  call vimshell#set_execute_file('txt,vim,c,h,cpp,d,xml,java,rb,pl', 'vim')

  let g:vimshell_split_command = 'tabnew'

  autocmd FileType vimshell call s:vimshell_my_settings()
  function! s:vimshell_my_settings() "{{{
    nmap <silent><buffer> <C-j>  <Plug>(vimshell_next_prompt)
    nmap <silent><buffer> <C-k>  <Plug>(vimshell_previous_prompt)
    nnoremap <silent><buffer> <C-p>  gT
    nnoremap <silent><buffer> <C-n>  gt

    call vimshell#altercmd#define('g', 'git')
    call vimshell#altercmd#define('l', 'll')
    call vimshell#altercmd#define('ll', 'ls -l')
    call vimshell#hook#add('chpwd', 'my_chpwd', 'g:my_chpwd')
  endfunction "}}}

  function! g:my_chpwd(args, context)
    call vimshell#execute('ls')
  endfunction

endif
" }}}

"---------------------------------------------------------------------------
" for airblade/vim-rooter {{{2
if s:bundled('vim-rooter')
  let g:rooter_use_lcd = 1
  let g:rooter_manual_only = 1

  augroup movecurrentdir
    autocmd!
    autocmd BufRead,BufEnter * call MoveRootDirOrCurrentFileDir()
  augroup END

  " Move project top directory with vim-rooter.
  " If can't, move current file's directory.
  function! MoveRootDirOrCurrentFileDir()
    let currentfile = expand("%:p")

    " Don't move if current file is an unnamed buffer
    if currentfile == ''
      return
    endif

    Rooter

    let cwd = getcwd()

    " Move current file's directory if could't move project top directory
    if (stridx(currentfile, cwd) != 0 ||
      \finddir('.git', cwd) == '') &&
      \isdirectory(expand('%:p:h'))
      lcd %:p:h
    endif
  endfunction
endif
" }}}

"---------------------------------------------------------------------------
" for airblade/vim-gitgutter {{{2
if s:bundled('vim-gitgutter')
  let g:gitgutter_enabled = 0
  nnoremap <Space>gg  :<C-u>GitGutterToggle<CR>
endif
" }}}

"---------------------------------------------------------------------------
" for basyura/J6uil.vim {{{2
"if s:bundled('J6uil.vim')
  augroup my_j6uil
    autocmd!
    autocmd CursorHold * call s:MyJ6uil_update()
  augroup END

  function! s:MyJ6uil_update()
    if &filetype == 'J6uil'
      let s:j6uil_user_color_list = [
        \ 'Red',
        \ 'Green',
        \ 'Blue',
        \ 'Cyan',
        \ 'Magenta',
        \ 'Yellow',
        \ 'Gray',
        \ 'Black',
        \ ]

      let w:j6uil_users = []
      call s:MyJ6uil_update_users()
      call s:MyJ6uil_colorise_user()
    endif
  endfunction

  function! s:MyJ6uil_colorise_user()
    let w:j6uil_last_highlight = 0
    let i = w:j6uil_last_highlight
    let color_len = len(s:j6uil_user_color_list)

    while i < len(w:j6uil_users)
      execute 'highlight MyJ6uilUser' . i . ' ' . 'guifg=' .
        \ s:j6uil_user_color_list[i % color_len]
        \ ' ctermfg=' .
        \ s:j6uil_user_color_list[i % color_len]
      call matchadd('MyJ6UilUser' . i, '\<'.w:j6uil_users[i].'\>')
      let i += 1
    endwhile
    let w:j6uil_last_highlight = i
  endfunction

  function! s:MyJ6uil_update_users()
    let w:j6uil_last_line = 0
    let i = w:j6uil_last_line

    while (i < line('$'))
      let line = getline(i)

      let user = matchstr(line, '^\(-- \)\@!\S\+')
      if user != '' &&
        \index(w:j6uil_users, user) == -1
        call add(w:j6uil_users, user)
      endif
      let i += 1
    endwhile

    let w:j6uil_last_line = line('$')
  endfunction

"endif
" }}}

"---------------------------------------------------------------------------
" for gregsexton/gitv {{{2
if s:bundled('gitv')
  let g:Gitv_OpenHorizontal = 1
  let g:Gitv_DoNotMapCtrlKey = 1
  let g:Gitv_TruncateCommitSubjects = 1

  set lazyredraw

  nnoremap [Git]v :Gitv --all<CR>
  vnoremap [Git]v :Gitv --all<CR>
  nnoremap [Git]V :Gitv! --all<CR>
  autocmd FileType gitv call s:my_gitv_settings()
  function! s:my_gitv_settings()
    setlocal iskeyword+=/,-,.
    nnoremap <silent><buffer> C :<C-u>Git checkout <C-r><C-w><CR>
  endfunction

endif
" }}}

"---------------------------------------------------------------------------
" for h1mesuke/vim-alignta {{{2
if s:bundled('vim-alignta')
  nnoremap <Leader>as :<C-u>Alignta =<CR>
  vnoremap <Leader>as :Alignta =<CR>
  nnoremap <Leader>a= :<C-u>Alignta =<CR>
  vnoremap <Leader>a= :Alignta =<CR>
  nnoremap <Leader>ah :<C-u>Alignta =><CR>
  nnoremap <Leader>ah :<C-u>Alignta =><CR>
  vnoremap <Leader>a> :Alignta =><CR>
  vnoremap <Leader>a> :Alignta =><CR>
  nnoremap <Leader>a, :<C-u>Alignta ,<CR>
  vnoremap <Leader>a, :Alignta ,<CR>
  nnoremap <Leader>a: :<C-u>Alignta :<CR>
  vnoremap <Leader>a: :Alignta :<CR>

  "augroup perllang
    "autocmd FileType perl vnoremap <space>ah  :<c-u>alignctrl l-l<cr>gv:align =><cr>
  "augroup end
endif
" }}}

"---------------------------------------------------------------------------
" for jpalardy/vim-slime {{{2
let g:slime_target = 'tmux'
let g:slime_paste_file = tempname()
" }}}

"---------------------------------------------------------------------------
" for kana/vim-altr {{{2
if s:bundled('vim-altr')
  call altr#remove_all()
  call altr#define('plugin/%/*.vim',
    \              'autoload/%/*.vim')
  call altr#define('plugin/%.vim',
    \              'autoload/%.vim')

  call altr#define('%.rb',
    \              'spec/%_spec.rb')
  call altr#define('app/models/%.rb',
    \              'spec/models/%_spec.rb',
    \              'spec/factories/%.rb')
  call altr#define('app/controllers/%.rb',
    \              'spec/controllers/%_spec.rb')
  call altr#define('app/helpers/%.rb',
    \              'spec/helpers/%_spec.rb')
  call altr#define('spec/routing/%_spec.rb',
    \              'config/routes.rb')

  call altr#define('%.c',
    \              '%.h')

  command! A  call altr#forward()
  command! B  call altr#back()

  nmap <Leader>m   <Plug>(altr-forward)
endif
" }}}

"---------------------------------------------------------------------------
" for kana/vim-submode {{{2
if s:bundled('vim-submode')
  let g:submode_keyseqs_to_leave = ['<Esc>']
  let g:submode_timeoutlen = 1000000
  let g:submode_keep_leaving_key = 1

  call submode#enter_with('undo/redo', 'n', '', 'g-', 'g-')
  call submode#enter_with('undo/redo', 'n', '', 'g+', 'g+')
  call submode#map('undo/redo', 'n', '', '-', 'g-')
  call submode#map('undo/redo', 'n', '', '+', 'g+')

  call submode#enter_with('window-size', 'n', '', '<C-w>+', '<C-w>+')
  call submode#enter_with('window-size', 'n', '', '<C-w>-', '<C-w>-')
  call submode#enter_with('window-size', 'n', '', '<C-w><', '<C-w><')
  call submode#enter_with('window-size', 'n', '', '<C-w>=', '<C-w>=')
  call submode#enter_with('window-size', 'n', '', '<C-w>>', '<C-w>>')
  call submode#map('window-size', 'n', '', '+', '<C-w>+')
  call submode#map('window-size', 'n', '', '-', '<C-w>-')
  call submode#map('window-size', 'n', '', '<', '<C-w><')
  call submode#map('window-size', 'n', '', '=', '<C-w>=')
  call submode#map('window-size', 'n', '', '>', '<C-w>>')

  call submode#enter_with('buffer-mode', 'n', '', 'gh', ':<C-u>bprevious<CR>')
  call submode#enter_with('buffer-mode', 'n', '', 'gl', ':<C-u>bnext<CR>')
  call submode#map('buffer-mode', 'n', '', 'h', ':<C-u>bprevious<CR>')
  call submode#map('buffer-mode', 'n', '', 'l', ':<C-u>bnext<CR>')
  call submode#map('buffer-mode', 'n', '', 'd', ':<C-u>bwipeout<CR>')

  call submode#enter_with('tab-mode', 'n', '', 'tl', 'gt')
  call submode#enter_with('tab-mode', 'n', '', 'th', 'gT')
  call submode#enter_with('tab-mode', 'n', '', 't<Space>h', ':<C-u>tabfirst<CR>')
  call submode#enter_with('tab-mode', 'n', '', 't<Space>l', ':<C-u>tablast<CR>')
  call submode#enter_with('tab-mode', 'n', '', 'tL', ':<C-u>tabmove +1<CR>')
  call submode#enter_with('tab-mode', 'n', '', 'tH', ':<C-u>tabmove -1<CR>')
  call submode#map('tab-mode', 'n', '', 'l', 'gt')
  call submode#map('tab-mode', 'n', '', 'h', 'gT')
  call submode#map('tab-mode', 'n', '', '<Space>h', ':<C-u>tabfirst<CR>')
  call submode#map('tab-mode', 'n', '', '<Space>l', ':<C-u>tablast<CR>')
  call submode#map('tab-mode', 'n', '', 'L', ':<C-u>tabmove +1<CR>')
  call submode#map('tab-mode', 'n', '', 'H', ':<C-u>tabmove -1<CR>')
  call submode#map('tab-mode', 'n', '', 't', ':<C-u>tabnew<CR>')
  call submode#map('tab-mode', 'n', '', 'd', ':<C-u>tabclose<CR>')

  call submode#enter_with('ex-move', 'nv', '', '<Space><Space>', '<Nop>')
  call submode#enter_with('ex-move', 'nv', '', '<Space>j', '<C-f>zz')
  call submode#enter_with('ex-move', 'nv', '', '<Space>k', '<C-b>zz')
  call submode#leave_with('ex-move', 'nv', '', '<Space>')
  call submode#map('ex-move', 'nv', '', 'j', '<C-f>zz')
  call submode#map('ex-move', 'nv', '', 'k', '<C-b>zz')
  call submode#map('ex-move', 'nv', '', 'n', '5jzz')
  call submode#map('ex-move', 'nv', '', 'm', '5kzz')
  call submode#map('ex-move', 'nv', '', 'l', '}zz')
  call submode#map('ex-move', 'nv', '', 'h', '{zz')

  call submode#enter_with('change-list', 'n', '', 'g;', 'g;zz')
  call submode#enter_with('change-list', 'n', '', 'g,', 'g,zz')
  call submode#map('change-list', 'n', '', ';', 'g;zz')
  call submode#map('change-list', 'n', '', ',', 'g,zz')

  call submode#enter_with('diff', 'n', '', '<Leader>d', '<Nop>')
  call submode#map('diff', 'n', '', 'j', ']czz') " next diff
  call submode#map('diff', 'n', '', 'k', '[czz') " prev diff
  call submode#map('diff', 'n', '', 'o', 'do') " get diff
  call submode#map('diff', 'n', '', 'p', 'dp') " put diff
  call submode#map('diff', 'n', '', 'u', 'do]czz') " get diff and next diff
  call submode#map('diff', 'n', '', 'i', 'dp]czz') " put diff and next diff

endif
" }}}

"---------------------------------------------------------------------------
" for kana/vim-operator-replace {{{2
if s:bundled('vim-operator-user') && s:bundled('vim-operator-replace')
  map s <Plug>(operator-replace)
  map S <Plug>(operator-replace)$
  " clipboardからoperator-replace
  map <Space>s "*<Plug>(operator-replace)
  map <Space>S "*<Plug>(operator-replace)$
endif
" }}}

"---------------------------------------------------------------------------
" for kana/vim-operator-user {{{2
if s:bundled('vim-operator-user')
    call operator#user#define_ex_command('blank-killer', 's/\s\+$//')
    nmap <Leader>bk <Plug>(operator-blank-killer)
endif
" }}}

"---------------------------------------------------------------------------
" for kana/vim-scratch {{{2
if s:bundled('vim-scratch')
  function! s:ScratchToggle()
    if exists("t:is_scratch_window")
      unlet t:is_scratch_window
      ScratchClose
      echo 'close'
    else
      let t:is_scratch_window = 1
      ScratchOpen
      echo 'open'
    endif
  endfunction

  command! -nargs=0 ScratchToggle call s:ScratchToggle()
  "nnoremap <Leader><Leader> :<C-u>ScratchToggle<CR>
endif
" }}}

"---------------------------------------------------------------------------
" for kana/vim-smartinput {{{2
if s:bundled('vim-smartinput')
  call smartinput#clear_rules()
  nnoremap <silent> <Leader>ie  :<C-u>call smartinput#define_default_rules()<CR>
  nnoremap <silent> <Leader>id  :<C-u>call smartinput#clear_rules()<CR>
endif
" }}}

"---------------------------------------------------------------------------
" for kana/vim-smarttill {{{2
if s:bundled('vim-smarttill')
  omap q  <Plug>(smarttill-t)
  omap Q  <Plug>(smarttill-T)
endif
" }}}

"---------------------------------------------------------------------------
" for kana/vim-smartword {{{2
if s:bundled('vim-smartword')
  nmap w  <Plug>(smartword-w)
  vmap w  <Plug>(smartword-w)
  map  b  <Plug>(smartword-b)
  map  e  <Plug>(smartword-e)

  if s:bundled('vim-submode')
    call submode#enter_with('ge-mode', 'nv', 'r', 'ge', '<Plug>(smartword-ge)')
    call submode#map('ge-mode', 'nv', 'r', 'e', '<Plug>(smartword-ge)')
  else
    nmap ge <Plug>(smartword-ge)
    vmap ge <Plug>(smartword-ge)
  endif
  omap ge <Plug>(smartword-ge)
endif
" }}}

"---------------------------------------------------------------------------
" for kien/ctrlp.vim {{{2
if s:bundled('ctrlp.vim')
  let g:ctrlp_map = ''
  let g:ctrlp_by_filename = 1
  let g:ctrlp_mruf_max = 200
  let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
  let g:ctrlp_prompt_mappings = {
    \ 'PrtBS()':              ['<c-h>', '<bs>'],
    \ 'PrtDelete()':          ['<del>'],
    \ 'PrtSelectMove("j")':   ['<c-n>', '<down>'],
    \ 'PrtSelectMove("k")':   ['<c-p>', '<up>'],
    \ 'PrtHistory(-1)':       ['<c-j>'],
    \ 'PrtHistory(1)':        ['<c-k>'],
    \ 'PrtCurLeft()':         ['<left>'],
    \ 'PrtCurRight()':        ['<right>'],
    \ }
  let g:ctrlp_reuse_window = 'netrw\|help\|quickfix\|NERD_tree_2\|__Tag_List__\|*Scratch*'

  nnoremap [ctrlp]  <Nop>
  nmap     <Space>c [ctrlp]

  nnoremap [ctrlp]b :<C-u>CtrlPBuffer<CR>
  nnoremap [ctrlp]m :<C-u>CtrlPMRUFiles<CR>
  nnoremap [ctrlp]u :<C-u>CtrlPMRUFiles<CR>
  nnoremap [ctrlp]f :<C-u>CtrlPCurFile<CR>
endif
" }}}

"---------------------------------------------------------------------------
" for mattn/zencoding-vim {{{2
let g:user_emmet_leader_key = '<c-y>'
let g:user_emmet_settings = {
  \  'lang' : 'ja',
  \  'html' : {
  \    'filters' : 'html',
  \    'indentation' : '  '
  \  },
  \  'xhtml' : {
  \    'filters' : 'html',
  \    'indentation' : '  '
  \  },
  \  'perl' : {
  \    'indentation' : '    ',
  \    'aliases' : {
  \      'req' : "require '|'"
  \    },
  \    'snippets' : {
  \      'use' : "use strict\nuse warnings\n\n",
  \      'w' : "warn \"${cursor}\";",
  \    },
  \  },
  \  'css' : {
  \    'filters' : 'fc',
  \  },
  \  'javascript' : {
  \    'snippets' : {
  \      'jq' : "$(function() {\n\t${cursor}${child}\n});",
  \      'jq:each' : "$.each(arr, function(index, item)\n\t${child}\n});",
  \      'fn' : "(function() {\n\t${cursor}\n})();",
  \      'tm' : "setTimeout(function() {\n\t${cursor}\n}, 100);",
  \    },
  \  },
  \}
" }}}

"---------------------------------------------------------------------------
" for mhinz/vim-startify {{{2
if s:bundled('vim-startify')
  let g:startify_custom_indices = ['f', 'g', 'h', 'r', 'i', 'o', 'b']
endif
" }}}

"---------------------------------------------------------------------------
" for mhinz/vim-signify {{{2
if s:bundled('vim-signify')
  let g:signify_disable_by_default = 1
  if s:bundled('vim-submode')
    call submode#enter_with('vim-signify', 'n', 'r', '<Leader>gj', '<Plug>(signify-next-hunk)zz')
    call submode#enter_with('vim-signify', 'n', 'r', '<Leader>gk', '<Plug>(signify-prev-hunk)zz')
    call submode#map('vim-signify', 'n', 'r', 'j', '<Plug>(signify-next-hunk)zz')
    call submode#map('vim-signify', 'n', 'r', 'k', '<Plug>(signify-prev-hunk)zz')
  else
    nmap <Leader>gj <Plug>(signify-next-hunk)zz
    nmap <Leader>gk <Plug>(signify-prev-hunk)zz
  endif
  nmap <Leader>gh <Plug>(signify-toggle-highlight)
  nmap <Leader>gt <Plug>(signify-toggle)
endif
" }}}

"---------------------------------------------------------------------------
" for motemen/git-vim {{{2
if s:bundled('git-vim')
  let g:git_no_map_default = 1
  let g:git_command_edit = 'leftabove new'
  let g:git_author_highlight = { 'deris0126': 'term=reverse cterm=bold ctermbg=12 gui=bold guibg=red' }
  let g:git_highlight_blame = 1
  let g:git_blame_width = 50

  nnoremap [git]     <Nop>
  nmap     <Space>g  [git]

  nnoremap [git]d :<C-u>GitDiff --no-prefix<CR>
  nnoremap [git]D :<C-u>GitDiff --no-prefix --cached<CR>
  nnoremap [git]s :<C-u>GitStatus<CR>
  nnoremap [git]l :<C-u>GitLog -u<CR>
  nnoremap [git]L :<C-u>GitLog -u \| head -10000<CR>
  nnoremap [git]a :<C-u>GitAdd<CR>
  nnoremap [git]A :<C-u>GitAdd <cfile><CR>
  nnoremap [git]c :<C-u>GitCommit<CR>
  nnoremap [git]C :<C-u>GitCommit --amend<CR>
  nnoremap [git]p :<C-u>Git push
  nnoremap [git]r :<C-u>GitPullRebase<CR>
  nnoremap [git]f :<C-u>GitCatFile %<CR>
  nnoremap [git]v :<C-u>GitVimDiffMerge<CR>
  nnoremap [git]b zR:<C-u>GitBlame<CR>

  augroup git_diff
    autocmd!
    " 差分間の移動
    autocmd FileType git-diff,git-log.git-diff nnoremap <silent><buffer> <C-j>  :<C-u>call search('^[^+-].*\n\zs[+-]', "W")<CR>
    autocmd FileType git-diff,git-log.git-diff nnoremap <silent><buffer> <C-k>  :<C-u>call search('^[^+-].*\n\zs[+-]', "bW")<CR>
  augroup END

  " inspired by ujihisa's vimrc!
  augroup git_log
    autocmd!
    autocmd FileType git-log setlocal filetype=git-log.git-diff
    autocmd FileType git-log setlocal foldmethod=expr
    autocmd FileType git-log setlocal foldexpr=getline(v:lnum)=~'^commit'?'>1':getline(v:lnum+1)=~'^commit'?'<1':'='
    autocmd FileType git-log setlocal foldtext=FoldTextOfGitLog()
  augroup END

  " Inspired by ujihisa's vimrc
  function! s:GitLogViewer()
    " vnewだとコミットメッセージが切れてしまうのでnew
    new
    VimProcRead git log -u 'ORIG_HEAD..HEAD'
    set filetype=git-log.git-diff
    setlocal foldmethod=expr
    setlocal foldexpr=getline(v:lnum)=~'^commit'?'>1':getline(v:lnum+1)=~'^commit'?'<1':'='
    setlocal foldtext=FoldTextOfGitLog()
  endfunction
  command! GitLogViewer call s:GitLogViewer()

  " git log表示時の折りたたみ用
  function! FoldTextOfGitLog()
    let month_map = {
      \ 'Jan' : '01',
      \ 'Feb' : '02',
      \ 'Mar' : '03',
      \ 'Apr' : '04',
      \ 'May' : '05',
      \ 'Jun' : '06',
      \ 'Jul' : '07',
      \ 'Aug' : '08',
      \ 'Sep' : '09',
      \ 'Oct' : '10',
      \ 'Nov' : '11',
      \ 'Dec' : '12',
      \ }

    if getline(v:foldstart) !~ '^commit'
      return getline(v:foldstart)
    endif

    if getline(v:foldstart + 1) =~ '^Author:'
      let author_lnum = v:foldstart + 1
    elseif getline(v:foldstart + 2) =~ '^Author:'
      " commitの次の行がMerge:の場合があるので
      let author_lnum = v:foldstart + 2
    else
      " commitの下2行がどちらもAuthor:で始まらなければ諦めて終了
      return getline(v:foldstart)
    endif

    let date_lnum = author_lnum + 1
    let message_lnum = date_lnum + 2

    let author = matchstr(getline(author_lnum), '^Author: \zs.*\ze <.\{-}>')
    let date = matchlist(getline(date_lnum), ' \(\a\{3}\) \(\d\{1,2}\) \(\d\{2}:\d\{2}:\d\{2}\) \(\d\{4}\)')
    let message = getline(message_lnum)

    let month = date[1]
    let day = printf('%02s', date[2])
    let time = date[3]
    let year = date[4]

    let datestr = join([year, month_map[month], day], '-')

    return join([datestr, time, author, message], ' ')
  endfunction

  function! BranchHashList()
    let branchhashlist = []
    let branchlist = BranchList()
    for branch in branchlist
      call add(branchhashlist, {
        \ 'branch'  : branch[0],
        \ 'hash'    : CommitHash(branch[0]),
        \ 'current' : branch[1],
        \ })
    endfor
    return branchhashlist
  endfunction

  function! CommitHash(branch)
    try
      let hash = system('git rev-parse ' . a:branch)
      let devidedhash = split(hash, '[\r\n]\+')
    catch
      return ''
    endtry

    return devidedhash[0]
  endfunction

  function! BranchList()
    let branchlist = []
    try
      let res = system('git branch -a')
      let lines = split(res, '[\r\n]\+')

      for line in lines
        let list = matchlist(line, '^\(.\).\%(remotes/\)\?\zs\S\+')
        let [branch, current] = list[0:1]
        if branch != ''
          call add(branchlist, [branch, current=='*'])
        endif
      endfor
    catch
      return []
    endtry

    return branchlist
  endfunction

endif
" }}}

"---------------------------------------------------------------------------
" for nathanaelkane/vim-indent-guides {{{2
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
" }}}

"---------------------------------------------------------------------------
" for osyo-manga/vim-pronamachang {{{2
if s:bundled('vim-pronamachang')
  let g:pronamachang_voice_root = '~/pronamachang'
endif
" }}}

"---------------------------------------------------------------------------
" for t9md/vim-quickhl {{{2
if s:bundled('vim-quickhl')
  nmap <Leader>hm <Plug>(quickhl-toggle)
  xmap <Leader>hm <Plug>(quickhl-toggle)
  nmap <Leader>hM <Plug>(quickhl-reset)
  xmap <Leader>hM <Plug>(quickhl-reset)
  nmap <Leader>hh <Plug>(quickhl-match)
  "let g:quickhl_keywords = [
  "    \ "keyword",
  "    \ ]
endif
" }}}

"---------------------------------------------------------------------------
" for t9md/vim-surround_custom_mapping {{{2
let g:surround_custom_mapping = {}
let g:surround_custom_mapping._ = {
  \ 's': " \r ",
  \ }
let g:surround_custom_mapping.perl = {
  \ 'Q': "q(\r)",
  \ 'D': "qq(\r)",
  \ 'o': "qw(\r)",
  \ }
let g:surround_custom_mapping.ruby = {
  \ '-':  "<% \r %>",
  \ '=':  "<%= \r %>",
  \ '9':  "(\r)",
  \ '5':  "%(\r)",
  \ '%':  "%(\r)",
  \ 'w':  "%w(\r)",
  \ '#':  "#{\r}",
  \ '3':  "#{\r}",
  \ 'e':  "begin \r end",
  \ 'E':  "<<EOS \r EOS",
  \ 'i':  "if \1if\1 \r end",
  \ 'u':  "unless \1unless\1 \r end",
  \ 'c':  "class \1class\1 \r end",
  \ 'm':  "module \1module\1 \r end",
  \ 'd':  "def \1def\1\2args\r..*\r(&)\2 \r end",
  \ 'p':  "\1method\1 do \2args\r..*\r|&| \2\r end",
  \ 'P':  "\1method\1 {\2args\r..*\r|&|\2 \r }",
  \ }
let g:surround_custom_mapping.javascript = {
  \ 'f':  "function(){ \r }"
  \ }
let g:surround_custom_mapping.vim= {
  \'f':  "function! \r endfunction"
  \ }
let g:surround_custom_mapping.snippet= {
  \'p':  "${\1num\1:\r}"
  \ }
" }}}

"---------------------------------------------------------------------------
" for t9md/vim-unite-ack {{{2
if has('mac') && s:bundled('unite.vim') && s:bundled('vim-unite-ack')
    let g:unite_source_ack_command = 'ack --no-heading --no-color -a'
    let g:unite_source_ack_enable_highlight = 1
endif
" }}}

"---------------------------------------------------------------------------
" for scrooloose/nerdtree {{{2
if s:bundled('nerdtree')
  nnoremap <Leader>n :<C-u>NERDTreeToggle<CR>
endif
" }}}

"---------------------------------------------------------------------------
" for scrooloose/syntastic {{{2
let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 2
" }}}

"---------------------------------------------------------------------------
" for terryma/vim-expand-region {{{2
if s:bundled('vim-expand-region')
  let g:expand_region_text_objects = {
    \ 'iW'  : 0,
    \ 'i]'  : 1,
    \ 'ib'  : 1,
    \ 'iB'  : 1,
    \ 'il'  : 0,
    \ 'ii'  : 0,
    \ 'ai'  : 0,
    \ 'ip'  : 0,
    \ }
  if s:bundled('vim-submode')
    call submode#enter_with('expand-region', 'nv', 'r', '<Leader>e', '<Plug>(expand_region_expand)')
    call submode#map('expand-region', 'nv', 'r', 'e', '<Plug>(expand_region_expand)')
    call submode#map('expand-region', 'nv', 'r', 's', '<Plug>(expand_region_shrink)')
  endif
endif
" }}}

"---------------------------------------------------------------------------
" for thinca/vim-ambicmd {{{2
if s:bundled('vim-ambicmd')
  cnoremap <expr> <Space>   ambicmd#expand("\<Space>")
  cnoremap <expr> <S-Space> ambicmd#expand("\<Space>")
  cnoremap <expr> <CR>      (getcmdtype() =~ '[/?]' ? "\<CR>zv" : ambicmd#expand("\<CR>"))

  function! g:ambicmd_my_custom_rule(cmd)
    return [
    \   '\c^' . a:cmd . '$',
    \   '\c^' . a:cmd,
    \   '\C^' . substitute(toupper(a:cmd), '.', '\0\\l*', 'g') . '$',
    \   '\C' . substitute(toupper(a:cmd), '.', '\0\\l*', 'g'),
    \   '\c' . a:cmd,
    \   '.*' . substitute(a:cmd, '.', '\0.*', 'g'),
    \   '\C^' . substitute(a:cmd, '^.', '\u\0', 'g') . '$',
    \   '\C^' . substitute(a:cmd, '^.', '\u\0', 'g'),
    \ ]
  endfunction
  let g:ambicmd#build_rule = 'g:ambicmd_my_custom_rule'
endif
" }}}

"---------------------------------------------------------------------------
" for thinca/vim-poslist {{{2
if s:bundled('vim-poslist')
  let g:poslist_histsize = 500

  map <C-o> <Plug>(poslist-prev-line)
  map <C-i> <Plug>(poslist-next-line)
  map <Leader><C-o> <Plug>(poslist-prev-buf)
  map <Leader><C-i> <Plug>(poslist-next-buf)
endif
" }}}

"---------------------------------------------------------------------------
" for thinca/vim-quickrun {{{2
if s:bundled('vim-quickrun')
  let g:quickrun_config = {}
  let g:quickrun_config._ = {
    \ 'runner' : 'vimproc',
    \ 'outputter/buffer/split' : 'botright 10sp',
    \ 'runmode' : 'async:vimproc'
    \ }

  let g:quickrun_config.markdown = {
    \ 'type'      : 'markdown/pandoc',
    \ 'outputter' : 'browser',
    \ 'cmdopt'    : '-s'
    \ }

  nnoremap <silent> <Leader>r  :<C-u>QuickRun -mode n<CR>
  vnoremap <silent> <Leader>r  :<C-u>QuickRun -mode v<CR>
  nnoremap <Leader>R           :<C-u>QuickRun -args ""<Left>
endif
" }}}

"---------------------------------------------------------------------------
" for thinca/vim-ref {{{2
if s:bundled('vim-ref')
  let g:ref_source_webdict_sites = {
    \   'default': 'alc',
    \
    \   'alc': {
    \       'url': 'http://eow.alc.co.jp/%s',
    \       'keyword_encoding': 'utf-8',
    \       'cache': '1',
    \   },
    \   'wikipedia': {
    \       'url': 'http://ja.wikipedia.org/wiki/%s',
    \   },
    \ }
  function! g:ref_source_webdict_sites.alc.filter(output)
    return join(split(a:output, "\n")[38 :], "\n")
  endfunction
  function! g:ref_source_webdict_sites.wikipedia.filter(output)
    return join(split(a:output, "\n")[6 :], "\n")
  endfunction

  nnoremap <Leader>wa :<C-u>Ref webdict alc <C-r><C-w><CR>
  vnoremap <Leader>wa :<C-u>call ExecuteWithSelectedText('Ref webdict alc %s')<CR>
  nnoremap <Leader>wA :<C-u>Ref webdict alc<Space>
  nnoremap <Leader>ww :<C-u>Ref webdict wikipedia <C-r><C-w><CR>
  vnoremap <Leader>ww :<C-u>call ExecuteWithSelectedText('Ref webdict wikipedia %s')<CR>
  nnoremap <Leader>wW :<C-u>Ref webdict wikipedia<Space>
endif
" }}}

"---------------------------------------------------------------------------
" for thinca/vim-visualstar {{{2
if s:bundled('vim-visualstar')
  map * <Plug>(visualstar-*)N
  map # <Plug>(visualstar-#)n
  map g* <Plug>(visualstar-g*)N
  map g# <Plug>(visualstar-g#)n
  map <Space>/ <Plug>(visualstar-*)N
  map <Space>? <Plug>(visualstar-#)n
  map g<Space>/ <Plug>(visualstar-g*)N
  map g<Space>? <Plug>(visualstar-g#)n
endif
" }}}

"---------------------------------------------------------------------------
" for tpope/vim-commentary {{{2
if s:bundled('vim-commentary')
  xmap <Leader>c   <Plug>Commentary
  nmap <Leader>c   <Plug>Commentary
  nmap <Leader>cc  <Plug>CommentaryLine
  nmap <Leader>cu  <Plug>CommentaryUndo
endif
" }}}

"---------------------------------------------------------------------------
" for tpope/vim-fugitive {{{2
if s:bundled('vim-fugitive')
  nnoremap [Git]     <Nop>
  nmap     <Space>g  [Git]

  nnoremap [Git]d :<C-u>Gdiff<CR>
  nnoremap [Git]s :<C-u>Gstatus<CR>
  nnoremap [Git]a :<C-u>Gwrite<CR>
  nnoremap [Git]A :<C-u>Gwrite <cfile><CR>
  nnoremap [Git]c :<C-u>Gcommit -v<CR>
  nnoremap [Git]C :<C-u>Gcommit --amend<CR>
  nnoremap [Git]b :<C-u>Gblame<CR>
  nnoremap [Git]p :<C-u>Git push<Space>
endif
" }}}

"---------------------------------------------------------------------------
" for tsukkee/lingr-vim {{{2
let g:lingr_vim_user = 'deris0126'
" }}}

"---------------------------------------------------------------------------
" for tyru/nextfile.vim {{{2
if s:bundled('nextfile.vim')
  let g:nf_include_dotfiles = 1
  let g:nf_loop_files = 1

  if s:bundled('vim-submode')
    call submode#enter_with('nextfile', 'n', 'r', '<Leader>j', '<Plug>(nextfile-next)')
    call submode#enter_with('nextfile', 'n', 'r', '<Leader>k', '<Plug>(nextfile-previous)')
    call submode#map('nextfile', 'n', 'r', 'j', '<Plug>(nextfile-next)')
    call submode#map('nextfile', 'n', 'r', 'k', '<Plug>(nextfile-previous)')
  else
    nmap <Leader>j  <Plug>(nextfile-next)
    nmap <Leader>k  <Plug>(nextfile-previous)
  endif
endif
" }}}

"---------------------------------------------------------------------------
" for tyru/open-browser.vim {{{2
if s:bundled('open-browser.vim')
  let g:netrw_nogx = 1 " disable netrw's gx mapping.
  nmap gx <Plug>(openbrowser-smart-search)
  vmap gx <Plug>(openbrowser-smart-search)

  map gz <Plug>(operator-open-neobundlepath)

  call operator#user#define('open-neobundlepath', 'OpenNeoBundlePath')
  function! OpenNeoBundlePath(motion_wise)
    if line("'[") != line("']")
      return
    endif
    let start = col("'[") - 1
    let end = col("']")
    let sel = strpart(getline('.'), start, end - start)
    let sel = substitute(sel, '^\%(github\|gh\|git@github\.com\):\(.\+\)', 'https://github.com/\1', '')
    let sel = substitute(sel, '^\%(bitbucket\|bb\):\(.\+\)', 'https://bitbucket.org/\1', '')
    let sel = substitute(sel, '^gist:\(.\+\)', 'https://gist.github.com/\1', '')
    let sel = substitute(sel, '^git://', 'https://', '')
    if sel =~ '^https\?://'
      call openbrowser#open(sel)
    elseif sel =~ '/'
      call openbrowser#open('https://github.com/'.sel)
    else
      call openbrowser#open('https://github.com/vim-scripts/'.sel)
    endif
  endfunction
endif
" }}}

"---------------------------------------------------------------------------
" for tyru/operator-html-escape.vim {{{2
if s:bundled('operator-user') && s:bundled('operator-html-escape.vim')
  nmap <Leader>he  <Plug>(operator-html-escape)
  nmap <Leader>hu  <Plug>(operator-html-unescape)
endif
" }}}

"---------------------------------------------------------------------------
" for tyru/operator-star.vim {{{2
if s:bundled('operator-user') && s:bundled('operator-star.vim')
  nmap <Leader>*  <Plug>(operator-*)
  nmap <Leader>g* <Plug>(operator-g*)
  nmap <Leader>#  <Plug>(operator-#)
  nmap <Leader>g# <Plug>(operator-g#)
endif
" }}}

"---------------------------------------------------------------------------
" for xolox/vim-easytags {{{2
if has('win32')
  let g:easytags_cmd = ''
endif
" }}}

"---------------------------------------------------------------------------
" for deris/columnjump {{{2
if s:bundled('columnjump')
  " TODO: vmapにも割り当てたいけどneocomとバッティングしている
  nmap <c-k> <Plug>(columnjump-backward)
  nmap <c-j> <Plug>(columnjump-forward)
endif
" }}}

"---------------------------------------------------------------------------
" for deris/vim-fitcolumn {{{2
if s:bundled('vim-fitcolumn')
  let g:fitcolumn_no_default_key_mappings = 1
  inoremap <expr> <C-j><C-k>  fitcolumn#fitabovecolumn({
    \ 'insertchar': ' ',
    \ })
  inoremap <expr> <C-j><C-j>  fitcolumn#fitbelowcolumn({
    \ 'insertchar': ' ',
    \ })
  imap <C-j><C-h>  <Plug>(fitcolumn-abovecolumn)
  imap <C-j><C-l>  <Plug>(fitcolumn-belowcolumn)
endif
" }}}

"---------------------------------------------------------------------------
" for deris/vim-rengbang {{{2
if s:bundled('vim-rengbang')
  map <Leader>sn <Plug>(operator-rengbang)
endif
" }}}

"---------------------------------------------------------------------------
" for errormarker.vim {{{2
let errormarker_disablemappings = 1
" }}}

"---------------------------------------------------------------------------
" for taglist.vim {{{2
if s:bundled('taglist.vim')
  if has('mac')
    let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"    "ctagsのパス
  elseif has('win32')
    let Tlist_Ctags_Cmd = "c:/usr/local/bin/ctags.exe"    "ctagsのパス
  endif
  "let Tlist_Show_One_File = 1               "現在編集中のソースのタグしか表示しない
  let Tlist_Exit_OnlyWindow = 1             "taglistのウィンドーが最後のウィンドーならばVimを閉じる
  let Tlist_Use_Right_Window = 1            "右側でtaglistのウィンドーを表示
  nnoremap <silent> <C-l> :<C-u>TlistToggle<CR>
endif
" }}}

"---------------------------------------------------------------------------
" for vim-textobj-function {{{2
if s:bundled('vim-textobj-user') && s:bundled('vim-textobj-function')
  let g:textobj_function_no_default_key_mappings = 1
  omap iF <Plug>(textobj-function-i)
  omap aF <Plug>(textobj-function-a)
  vmap iF <Plug>(textobj-function-i)
  vmap aF <Plug>(textobj-function-a)
endif
" }}}

" }}}

"---------------------------------------------------------------------------
" __END__  "{{{1
" vim: expandtab softtabstop=2 shiftwidth=2
" vim: foldmethod=marker
" }}}

