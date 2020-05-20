" Commented plugins are those I haven't yet tried, whereas uncommented are
" those I abandoned after trying

call plug#begin()
" Color themes
Plug 'dracula/vim', {'as':'dracula'}
Plug 'rakr/vim-one'

" Simple example of the floating window API
" Plug 'Kraust/floater.nvim'

" Emacs-like plugins
Plug 'liuchengxu/vim-which-key'
Plug 'sunaku/vim-shortcut'

" Plug 'majutsushi/tagbar'
" Plug 'pechorin/any-jump.vim'
" Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

" Consider configuring this for R and vimscript. It's very simple:
" You specify legal variable characters and blacklist keywords
" Plug 'jaxbot/semantic-highlight.vim'
" Compare to semantic-highlight.vim
" The source for UpdateRemotePlugins isn't loaded yet:
" Plug 'numirias/semshi', { 'do': 'nvim +UpdateRemotePlugins +qall' }
call plug#end()

" vim-which-key: Display key bindings mapped to (local) leader
if has_key(g:plugs, 'vim-which-key')
    nnoremap <silent> <leader>      :<c-u>WhichKey g:mapleader<CR>
    nnoremap <silent> <localleader> :<c-u>WhichKey g:maplocalleader<CR>
    let g:which_key_fallback_to_native_key = 1
    "nnoremap <silent> g :<c-u>WhichKey 'g'<CR>

    "let g:WhichKeyFormatFunc = function('my_wk_format')
    let g:which_key_use_floating_win = 1
    if g:which_key_use_floating_win
        let g:which_key_floating_opts = {'col': -2, 'width': +3}
        " if g:colors_name == 'dracula'
            " hi link WhichKeyFloating DraculaFg
        " endif
    endif
endif

" vim-shortcut: Fuzzy key finder
if has_key(g:plugs, 'vim-shortcut')
    runtime plugin/shortcut.vim
    source ~/.config/nvim/base_shortcuts.vim
    "noremap <C-Space> :Shortcuts<CR>
endif


if has_key(g:plugs, 'vim-clap')
    Shortcut Fuzzy lines in the current buffer
                \ noremap <Leader>fl :<c-u>Clap blines<CR>
    Shortcut Fuzzy lines in open buffers
                \ noremap <Leader>fL :<c-u>Clap lines<CR>
    Shortcut Fuzzy commands
                \ noremap <Leader>fc :<c-u>Clap command<CR>
    Shortcut Fuzzy commmand history
                \ noremap <Leader>f: :<c-u>Clap hist:<CR>
    Shortcut Fuzzy search history
                \ noremap <Leader>f/ :<c-u>Clap hist/<CR>
    Shortcut Fuzzy open buffers and v:oldfiles
                \ noremap <Leader>fm :<c-u>Clap history<CR>
    Shortcut Fuzzy file finder
                \ noremap <Leader>ff :<c-u>Clap files ++finder=fd --type f --hidden .<CR>
    Shortcut Fuzzy file explorer
                \ noremap <Leader>fF :<c-u>Clap filer<CR>
    Shortcut Fuzzy grep
                \ noremap <Leader>fg :<c-u>Clap grep<CR>
    Shortcut Fuzzy helptags
                \ noremap <Leader>fh :<c-u>Clap help_tags<CR>
    " https://medium.com/breathe-publication/understanding-vims-jump-list-7e1bfc72cdf0
    Shortcut Fuzzy jump history
                \ noremap <Leader>fj :<c-u>Clap jumps<CR>
    Shortcut Fuzzy registers
                \ noremap <Leader>fr :<c-u>Clap registers<CR>
    Shortcut Fuzzy yank stack
                \ noremap <Leader>fy :<c-u>Clap yanks<CR>
endif


if has_key(g:plugs, 'nerdcommenter')
    " Behavior of commands depends on variable settings above.
    Shortcut! <Leader>cc       Comment line or selection
    Shortcut! <Leader>cn       Comment line or selection with nesting
    Shortcut! <Leader>c<space> Toggle comment (based on topmost line)
    Shortcut! <leader>cm       Comment selected lines using multipart delimiters
    Shortcut! <leader>ci       Invert the commented state of each selected line
    Shortcut! <leader>cs       Comment sexily
    Shortcut! <leader>c$       Comment from cursor to EOL
    Shortcut! <leader>cA       Append comment delimiter to EOL and enter insert mode
    Shortcut! <leader>ca       Switch to alternate comment delimiter if available
    Shortcut! <leader>cl       Comment line or selection and align delimiters
    Shortcut! <leader>cu       Uncomment line or selection
    Shortcut                   (insert) Add comment delimiter at cursor
                \ imap <C-c> <plug>NERDCommenterInsert
endif

" Earlier notes and edits lumped together here -------------------------------

" TIP: Renaming using vim:
" https://vi.stackexchange.com/questions/18004/renaming-variables
" My own autopairs
" https://stackoverflow.com/questions/13404602/how-to-prevent-esc-from-waiting-for-more-input-in-insert-mode
" https://vim.fandom.com/wiki/Automatically_append_closing_characters (see the
" plugins at the end of the webpage)
"NOTE: Unless both ( and (<CR> are bound, FastEscape won't affect them. In
"other words, if only the character itself is bound rather than a key sequence
"starting with the character, FastEscape is ignored! That's awesome.
augroup FastEscape
      autocmd!
      au InsertEnter * set timeoutlen=500
      au InsertLeave * set timeoutlen=1000
augroup END
" Autopair mappings:
" https://vim.fandom.com/wiki/Automatically_append_closing_characters

" Example for Vim. Vim indents on a line following :fu. <C-d> deletes the
" indentation, then <C-o> inserts a line above that is auto-indented
"inoremap (<CR> (<CR><C-d>)<C-o>O


" Note that submodes can not accommodate counts. You could investigate
" tinykeymap, but I couldn't get window movement to work:
" https://github.com/vim-scripts/tinykeymap/blob/master/autoload/tinykeymap/map/windows.vim
" Doing so would enable proper use of c-w x, for swapping w/ the n-th window
" Submodes also don't seem to support commands in {RHS}

" Using tmux and vim:
" https://statico.github.io/vim3.html
" The example here is a vim binding to execute the previous command in a
" terminal's command histroy. It relies on tmux to send keys between
" terminals. This is useful if you're editing a script and want to test it. Of
" course, this can probably be done in vim directly.

" For LSP with R, see either LanguageClient-neovim or coc-r-lsp and coc.nvim:
" https://cran.r-project.org/web/packages/languageserver/readme/README.html
" Note that only LC-neovim, not coc.nvim, is designed to integrate with ncm2
" and thus ncm-r. ALthough code is provided to integrate somewhat:
" https://github.com/ncm2/ncm2/issues/51
" Is this true? What about b:coc_suggest_disable? Or is this issue using coc
" for completion?
" https://cran.r-project.org/web/packages/languageserver/readme/README.html
" General tutorial:
" https://jacky.wtf/weblog/language-client-and-neovim/
" Consider coc.nvim for other languages:
" https://www.narga.net/how-to-set-up-code-completion-for-vim/#why_is_cocvim
" syntastics vs ale vs coc.nvim

" Windoes management sucks. See:
" https://github.com/spolu/dwm.vim
" https://www.reddit.com/r/vim/comments/3htkd7/rotate_windows_clockwise_anticlockwise/

" Neovim GUIs and packages:
" https://github.com/neovim/neovim/wiki/Related-projects

" Example of calling function from command (see f-args)
    function! MyEdit(x)
        " Disable partial matching for :sb and avoid errors for non-matches
        if bufexists(a:x)
            execute 'sb' a:x
        else
            execute 'buffer' a:x
        endif
    endfunction
    command! -bang -nargs=1 Test call MyEdit(<f-args>)

" TODO: Parse lines to get keys bound to each submode, invert, write vim commands,
" save to file, then source in vim
" By default, any unbound key exits the mode. Therefore, to prevent any key
" but the desired exit key from leaving the submode, bind all unused keys
" to <Nop>. See submode#unmap
function! s:getmap()
    silent !rm -f ~/.config/nvim/map.txt
    redir > ~/.config/nvim/map.txt
    silent map
    redir END
endfunction
autocmd VimEnter * call s:getmap()

function! s:csk()
    silent !rm -f temp
    redir > temp
    silent echo ctrlspace#keys#KeyMap()
    redir END
endfunction
autocmd VimEnter * call s:csk()

" Tags (in R)
" https://docs.ctags.io/en/latest/index.htmf
" https://ricostacruz.com/til/navigate-code-with-ctags (see shortcuts)
" https://www.fusionbox.com/blog/detail/navigating-your-django-project-with-vim-and-ctags/590/
" https://vim.fandom.com/wiki/Browsing_programs_with_tags" https://github.com/lyuts/vim-rtags

" You can generate tags for R in ctags, or use rtags and etags2ctags
" https://tinyheero.github.io/2017/05/13/r-vim-ctags.html
" https://stackoverflow.com/questions/4794859/exuberant-ctags-with-r
" etags2ctags is provided by nvim-r

function! <SID>NewOrOpen()
    let ntbufl = filter(map(tabpagebuflist(tabpagenr()), 'getbufinfo(v:val)[0]'), 'has_key(v:val.variables, "neoterm_id")')
    if len(ntbufl) > 0
        " let ntbuf = ntbufl[0].bufnr
        " exec g:neoterm_default_mod.' split '.bufname(ntbuf)
        Topen
    else
        Tnew
    endif
endfunction
nnoremap <localleader>o :<c-u>call <SID>NewOrOpen()<CR>


" Reason for double backslashes: |literal-string| or the paragraph above
" |expr5|. This seems similar to R's need for double backslashes. In R,
" string processing is followed by regex processing when using a regex
" function. In VIM, it seems that double qutoes, rather than a regex function
" like grep(), are the trigger. Here are examples from my edits to the neoterm
" plugin:
let pycommand = filter(a:command, 'v:val !~ "^\\s*$"')
let prev_indent = len(matchstr(prev_line, '^\s*'))

= Neoterm =

" Input is sent to the last active terminal or the terminal whose ID matches
" the numeric prefix of the command. Note that :[N]<command> really means
" press N, then :<command>. If you want to allow a numeric prefix in mapped
" commands, don't use <c-u> to clear the range.
" neoterm automatically increments the termid for each new terminal made
" by :Tnew. This makes using commands that take termid as a range/count
" difficult, beause there's the counter doesn't decrement after killing a
" terminal (as opposed to hiding it). An alternative is to associate each
" terminal with a tab and to omit counts altogether, using
" g:neoterm_term_per_tab. Using :Topen or :Ttoggle instead
" of :Tnew ensures only one terminal per tab.

" Note. If full text isn't showing up in terminal, but no errors are thrown,
" increase sleep.
function! Test(...) range
    " if (g:neoterm_repl_command =~ 'ipython')
    let lines = getline(a:firstline, a:lastline)
    call neoterm#exec({'cmd': ['%cpaste -q', '']})
    sleep 100m
    call neoterm#exec({'cmd': add(lines, '')})
    sleep 100m
    call neoterm#exec({'cmd': ['--', '']})
    " endif
endfunction

map <localleader>z :call Test()<cr>
