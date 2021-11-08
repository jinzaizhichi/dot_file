" Maintainer:	Bram Moolenaar <Bram@vim.org>

" bail out if this isn't wanted (mrsvim.vim uses this).
if exists("g:skip_loading_mswin") && g:skip_loading_mswin
  finish
endif


" set 'selection', 'selectmode', 'mousemodel' and 'keymodel' for MS-Windows
behave mswin

" Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature.  They are pasted as if they
" were characterwise instead.
" Uses the paste.vim autoload script.
" Use CTRL-G u to have CTRL-Z only undo the paste.

" if 1
    " exe 'inoremap <script> <C-V> <C-G>u' . paste#paste_cmd['i']
    " exe 'vnoremap <script> <C-V> ' . paste#paste_cmd['v']
" endif
"
" imap <S-Insert>		<C-V>
" vmap <S-Insert>		<C-V>



" 有gui也用不了,先放着
if has("gui")
  " echo "wf_vim has gui"
  " CTRL-F is the search dialog
  noremap  <expr> <C-F> has("gui_running") ? ":promptfind\<CR>" : "/"
  inoremap <expr> <C-F> has("gui_running") ? "\<C-\>\<C-O>:promptfind\<CR>" : "\<C-\>\<C-O>/"
  cnoremap <expr> <C-F> has("gui_running") ? "\<C-\>\<C-C>:promptfind\<CR>" : "\<C-\>\<C-O>/"

  " CTRL-G is the replace dialog,
  " but in console, it might be backspace, so don't map it there
  nnoremap <expr> <C-G> has("gui_running") ? ":promptrepl\<CR>" : "\<C-G>"
  inoremap <expr> <C-G> has("gui_running") ? "\<C-\>\<C-O>:promptrepl\<CR>" : "\<C-G>"
  cnoremap <expr> <C-G> has("gui_running") ? "\<C-\>\<C-C>:promptrepl\<CR>" : "\<C-G>"
endif

func! _useless()
" backspace in Visual mode deletes selection
vnoremap <BS> d
if has("clipboard")
    echo 'wf_has clip'
    " CTRL-X and SHIFT-Del are Cut
    vnoremap <C-X> "ax

    " CTRL-C and CTRL-Insert are Copy
    " lwf把"+寄存器改成了"a  (因为找不到"+
    vnoremap <C-C> "ay

    " CTRL-V and SHIFT-Insert are Paste
    map <C-V>		"agP
    " cmap <C-V>		<C-R>+
endif

" Alt-Space is System menu
if has("gui")
  noremap <M-Space> :simalt ~<CR>
  inoremap <M-Space> <C-O>:simalt ~<CR>
  cnoremap <M-Space> <C-C>:simalt ~<CR>
endif

" CTRL-A is Select all
" noremap <C-A> gggH<C-O>G
" inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
" cnoremap <C-A> <C-C>gggH<C-O>G
" onoremap <C-A> <C-C>gggH<C-O>G
" snoremap <C-A> <C-C>gggH<C-O>G
" xnoremap <C-A> <C-C>ggVG

endfunc
