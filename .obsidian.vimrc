set clipboard=unnamedplus
" set clipboard+=unnamedplus

" 1 tab == 4 spaces
set tabstop=4

" Linebreak on 500 characters
set tw=500

unmap <Space>

exmap reloadapp obcommand app:reload
nmap <Space>. :reloadapp<CR>

" Ignore compiled files

" Have j and k navigate visual lines rather than logical ones
nmap j gj
nmap k gk

" noremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
" noremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'


" Exit insert
inoremap kj <Esc>
inoremap jk <Esc>
" inoremap jj <Esc>
" inoremap kk <Esc>

" I like using H and L for beginning/end of line
" nmap H ^
" nmap L $

noremap [ (
noremap ] )

exmap contextmenu obcommand editor:context-menu
nnoremap zy :contextmenu<CR>
vnoremap zy :contextmenu<CR>
nnoremap zl :contextmenu<CR>
vnoremap zl :contextmenu<CR>

vnoremap <Space>la :contextmenu<CR>
vnoremap <Space>la :contextmenu<CR>

exmap nextsuggestion obcommand obsidian-languagetool-plugin:ltjumpp-to-next-suggestion
nnoremap ge :nextsuggestion<CR>
vnoremap ge :nextsuggestion<CR>


nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz

" Home / End
nnoremap H ^
nnoremap L $

vnoremap H ^
vnoremap L $

""" Sub modes/operations - yank, delete etc
nmap YH y^
nmap YL y$

exmap copyurl obcommand workspace:copy-url
nmap yu :copyurl<CR>



" zooming controls

exmap zoomin obcommand window:zoom-in
exmap zoomout obcommand window:zoom-out
exmap resetzoom obcommand window:reset-zoom

nmap zi :zoomin<CR>
nmap zo :zoomout<CR>
nmap ze :resetzoom<CR>
nmap z= :resetzoom<CR>
vmap z= :resetzoom<CR>


" exmap deletetostart obcommand obsidian-editor-shortcuts:deleteToStartOfLine
" nmap dH :deletetostart
" exmap deletetoend obcommand obsidian-editor-shortcuts:deleteToEndOfLine
" nmap dL :deletetoend

""" Pasting
vmap p "_dP
nnoremap P P<CR>

" exmap fileexploreropen obcommand file-explorer:open
" map <Space>e :fileexploreropen<CR>
"
" exmap fileexplorerhl obcommand file-explorer:reveal-active-file 
" map <Space>E :fileexplorerhl<CR>

exmap explorercurrent obcommand quick-explorer:browse-current
map <Space>e :explorercurrent<CR>

exmap explorer obcommand quick-explorer:browse-vault
map <Space>E :explorer<CR>


" Quickly remove search highlights
exmap focuseditor obcommand editor:focus
" nmap <Esc> :nohl<CR>
nmap <Esc> :nohl<CR>:focuseditor<CR>

" Yank to system clipboard
set clipboard=unnamedplus

" Go back and forward with Ctrl+O and Ctrl+I
" (make sure to remove default Obsidian shortcuts for these to work)
exmap back obcommand app:go-back
nmap <C-o> :back<CR>
exmap forward obcommand app:go-forward
nmap <C-i> :forward<CR>




vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>



" Surrounds
exmap surround_wiki surround [[ ]]
exmap surround_double_quotes surround " "
exmap surround_single_quotes surround ' '
exmap surround_backticks surround ` `
exmap surround_brackets surround ( )
exmap surround_square_brackets surround [ ]
exmap surround_curly_brackets surround { }

" NOTE: must use 'map' and not 'nmap'
map [[ :surround_wiki<CR>
nunmap s
vunmap s
map s" :surround_double_quotes<CR>
map s' :surround_single_quotes<CR>
map s` :surround_backticks<CR>
map sb :surround_brackets<CR>
map s( :surround_brackets<CR>
map s) :surround_brackets<CR>
map s[ :surround_square_brackets<CR>
map s] :surround_square_brackets<CR>
map s{ :surround_curly_brackets<CR>
map s} :surround_curly_brackets<CR>


" tmap <C-h> <cmd>wincmd h<CR>
" tmap <C-j> <cmd>wincmd j<CR>
" tmap <C-k> <cmd>wincmd k<CR>
" tmap <C-l> <cmd>wincmd l<CR>
" tmap <C-/> <cmd>close<cr>
" tmap <C-_> <cmd>close<cr>

" exmap link obcommand editor:open-link
" nmap gx :link


exmap splith obcommand workspace:split-horizontal
nmap <C-w>s :splith<CR>
nmap <C-w>- :splith<CR>

exmap splitv obcommand workspace:split-vertical
nmap <C-w>v :splitv<CR>
nmap <C-w>| :splitv<CR>

exmap movenextwindow obcommand workspace:move-to-next-window
nmap <C-w>w :movenextwindow<CR>

" closewindow is mapped, just below the savefile command

" nmap <C-w>e :equalize

exmap editfiletitle obcommand workspace:edit-file-title
map gI :editfiletitle<CR>

" Emulate Folding https://vimhelp.org/fold.txt.html#fold-commands
exmap togglefold obcommand editor:toggle-fold
nmap zO :togglefold<CR>
nmap zc :togglefold<CR>
nmap za :togglefold<CR>

exmap unfoldall obcommand editor:unfold-all
nmap zR :unfoldall<CR>

exmap foldall obcommand editor:fold-all
nmap zM :foldall<CR>

exmap tabnext obcommand workspace:next-tab
nmap <Space>bn :tabnext<CR>
exmap tabprev obcommand workspace:previous-tab
nmap <Space>bp :tabprev<CR>


exmap focuspanetop obcommand editor:focus-top
nmap <C-w>k :focuspanetop<CR>
nmap <C-w><C-k> :focuspanetop<CR>

exmap focuspanebottom obcommand editor:focus-bottom
nmap <C-w>j :focuspanebottom<CR>
nmap <C-w><C-j> :focuspanebottom<CR>

exmap focuspaneleft obcommand editor:focus-left
nmap <C-w>h :focuspaneleft<CR>
nmap <C-w><C-h> :focuspaneleft<CR>

exmap focuspaneright obcommand editor:focus-right
nmap <C-w>l :focuspaneright<CR>
nmap <C-w><C-l> :focuspaneright<CR>


exmap gotolasttab obcommand workspace:goto-last-tab
nmap <Space>bl :gotolasttab<CR>
nmap g$ :gotolasttab<CR>

exmap gotofirsttab obcommand workspace:goto-tab-1
nmap <Space>bf :gotofirsttab<CR>
nmap g^ :gotofirsttab<CR>

exmap followlink obcommand editor:follow-link
nmap gx :followlink<CR>
nmap gf :followlink<CR>


vmap gf :followlink<CR>
vmap gx :followlink<CR>


" Fix dropping the selection on indent
exmap betterindent obcommand >gv
exmap betteroutdent obcommand <gv
" hmmmmmmmmmm


exmap undowclosepane obcommand workspace:undo-close-pane
map <Space>fl :undowclosepane<CR>

exmap dailynotes obcommand daily-notes
map <Space>ft :dailynotes<CR>


" This is like - FULL reader mode
exmap togglereadmode obcommand markdown:toggle-preview
nmap <Space>tR :togglereadmode<CR>

exmap togglepreview obcommand editor:toggle-source 
nmap <Space>tm :togglepreview<CR>



exmap togglebold obcommand editor:toggle-bold
exmap toggleitalics obcommand editor:toggle-italics
exmap togglestrike obcommand editor:toggle-strikethrough
exmap togglehl obcommand editor:toggle-highlight
exmap togglecode obcommand editor:toggle-code
exmap toggleinlinemath obcommand editor:toggle-inline-math
exmap toggleblockquote obcommand editor:toggle-blockquote

exmap togglecomments obcommand editor:toggle-comments
exmap togglechecklist obcommand editor:toggle-checklist-status
exmap togglebulletlist obcommand editor:toggle-bullet-list
exmap togglenumberedlist obcommand editor:toggle-numbered-list

map <Space>tb :togglebold<CR>
map <Space>ti :toggleitalics<CR>
map <Space>ts :togglestrike<CR>
map <Space>ty :togglehl<CR>
map <Space>tc :togglecode<CR>
map <Space>tM :toggleinlinemath<CR>
map <Space>tq :toggleblockquote<CR>
map <Space>gcc :togglecomments<CR>

map <Space>to :togglechecklist<CR>
map <Space>tk :togglebulletlist<CR>
map <Space>tn :togglenumberedlist<CR>


exmap insertrule obcommand editor:insert-horizontal-rule
nmap <Space>t- :insertrule<CR>


exmap insertcallout obcommand editor:insert-callout
exmap insertcodebloc obcommand editor:insert-codeblock
exmap insertmathbloc obcommand editor:insert-mathblock
exmap inserttable obcommand editor:insert-table

nmap <Space>ic :insertcallout<CR>
nmap <Space>iC :insertcodebloc<CR>
nmap <Space>im :insertmathbloc<CR>
nmap <Space>it :inserttable<CR>



exmap toggleleftsidebar obcommand app:toggle-left-sidebar
exmap togglerightsidebar obcommand app:toggle-right-sidebar

" This need to flip if I use the 'hidden' setting for the application menu bar
" lol
nmap <Space>th :toggleleftsidebar<CR>
nmap <Space>tl :togglerightsidebar<CR>


exmap metadataproperty obcommand markdown:edit-metadata-property
nmap <Space>am :metadataproperty<CR>

exmap newfile obcommand file-explorer:new-file
exmap newfileincurrenttab obcommand file-explorer:new-file-in-current-tab
exmap newfileinnewpane obcommand file-explorer:new-file-in-new-pane
exmap movefile obcommand file-explorer:move-file
exmap duplicatefile obcommand file-explorer:duplicate-file
exmap deletefile obcommand app:delete-file 
exmap newfolder obcommand file-explorer:new-folder

nmap <Space>fn :newfile<CR>
nmap <Space>fN :newfolder<CR>

nmap <Space>fa :newfile<CR>
nmap <Space>fA :newfolder<CR>


nmap <Space>fc :newfileincurrenttab<CR>
nmap <Space>fp :newfileinnewpane<CR>
nmap <Space>fm :movefile<CR>
nmap <Space>fd :deletefile<CR>
nmap <Space>yi :duplicatefile<CR>

exmap savefile obcommand editor:save-file 
map :w :savefile<CR>
map :wa :savefile<CR>

exmap closewindow obcommand workspace:close
nmap <C-w>q :closewindow<CR>
map :q :closewindow<CR>
map :wq :closewindow<CR>

exmap closetabgroup obcommand workspace:close-tab-group
map :wqa :closetabgroup<CR>



exmap movecursorup obcommand obsidian-editor-shortcuts:moveCursorUp
nmap <C-k> :movecursorup<CR>

exmap globalsearch obcommand global-search:open
nmap <Space>fw :globalsearch<CR>

exmap findfile obcommand darlal-switcher-plus:switcher-plus:open
nmap <Space>ff :findfile<CR>


exmap findcommands obcommand darlal-switcher-plus:switcher-plus:open-commands
map <Space>fc :findcommands<CR>

exmap findbuffers obcommand darlal-switcher-plus:switcher-plus:open-editors
map <Space>fb :findbuffers<CR>

exmap findstarred obcommand darlal-switcher-plus:switcher-plus:open-starred
map <Space>fx :findstarred<CR>

" Pane relief
exmap first obcommand pane-relief:go-1st
map <C-1> :first<CR>

exmap second obcommand pane-relief:go-2st
map <C-2> :second<CR>

exmap third obcommand pane-relief:go-3st
map <C-3> :third<CR>

exmap fourth obcommand pane-relief:go-4st
map <C-4> :fourth<CR>

exmap fith obcommand pane-relief:go-5st
map <C-5> :fith<CR>

exmap sixth obcommand pane-relief:go-6st
map <C-6> :sixth<CR>

exmap seventh obcommand pane-relief:go-7st
map <C-7> :seventh<CR>

exmap eighth obcommand pane-relief:go-8st
map <C-8> :eighth<CR>


exmap swapnext obcommand pane-relief:swap-next
" map <Space>ww :swapnext<CR>
map <C-w>n :swapnext<CR>

exmap swapprev obcommand pane-relief:swap-prev
" map <Space>W :swapprev<CR>
map <C-w>p :swapprev<CR>


exmap movenewwindow obcommand workspace:move-to-new-window
map <C-w>O :movenewwindow<CR>


" exmap winfirst obcommand pane-relief:win-1st
" map <Space>1 :winfirst<CR>
" "
" exmap winsecond obcommand pane-relief:win-2nd
" map <Space>2 :winsecond<CR>
"
" exmap winthird obcommand pane-relief:win-3st
" map <C-w># :winthird<CR>
"
" exmap winfourth obcommand pane-relief:win-4st
" map <C-w>$ :winfourth<CR>
"
" exmap winfith obcommand pane-relief:win-5st
" map <C-w>% :winfith<CR>
"
" exmap winsixth obcommand pane-relief:win-6st
" map <C-w>^ :winsixth<CR>
"
" exmap winseventh obcommand pane-relief:win-7st
" map <C-w>& :winseventh<CR>
"
" exmap wineighth obcommand pane-relief:win-8st
" map <C-w>* :wineighth<CR>


" exmap fileswitcheropen obcommand obsidian-switcher-plus:open
" nmap <Space>ff :fileswitcheropen<CR>

" Git stuff
exmap giteditignore obcommand obsidian-git:edit-gitignore
nmap <Space>g. :giteditignore<CR>

exmap gitwindow obcommand obsidian-git:open-git-view
nmap <Space>gw :gitwindow<CR>

exmap githistory obcommand obsidian-git:open-history-view
nmap <Space>gh :githistory<CR>

exmap gitdiff obcommand obsidian-git:open-diff-view
nmap <Space>gd :gitdiff<CR>

exmap gitonlineview obcommand obsidian-git:view-file-on-github
nmap <Space>go :gitonlineview<CR>

exmap gitpull obcommand obsidian-git:pull
nmap <Space>gp :gitpull<CR>

exmap gitswitch obcommand obsidian-git:switch-to-remote-branch
nmap <Space>g- :gitswitch<CR>

exmap gitpush obcommand obsidian-git:push
nmap <Space>gP :gitpush<CR>

exmap gitcommit obcommand obsidian-git:commit
nmap <Space>gc :gitcommit<CR>

exmap gitcommitmessaged obcommand obsidian-git:commit-specified-message 
nmap <Space>gC :gitcommitmessaged<CR>

exmap gitstage obcommand obsidian-git:stage-current-file
nmap <Space>gs :gitstage<CR>

exmap gitunstage obcommand obsidian-git:unstage-current-file
nmap <Space>gu :gitunstage<CR>

