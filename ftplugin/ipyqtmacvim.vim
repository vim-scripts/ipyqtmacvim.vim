" ipyqtmacvim - Plugin to send commands from MacVim to IPython Qt console
"
" Language:     Python
" Maintainer:   Justin Kitzes <jkitzes@berkeley.edu>
" License:      BSD New
" Requires:     MacVim 7.3, Mac OS X (osascript), IPython 0.12
" Last Change:  2012-02-15
" Version:      0.1
"
" Interface between MacVim and IPython Qt console for Mac.
"
" This plugin provides the ability to run an entire file, a line, or
" highlighted text from MacVim directly in the IPython 0.12 Qt console. This is 
" intended to replicate the look and feel of integrated GUI environments such 
" as R for Mac OS X, in which a user has an open editor window next to a 
" console window, and within which a shortcut command will send lines or the 
" entire file from the editor window directly to the console window.
" 
" ipyqtmacvim accomplishes this via some copy/paste trickery - it copies the 
" selection or file path to the system clipboard, switches to the Qt console 
" window, and pastes the command. <Cmd-4> will run a single line (normal mode) 
" or a selection (visual mode) and <Cmd-5> will run the entire file (you can 
" customize these hotkeys at the end of this plugin).
" 
" The plugin requires a companion Applescript file ipyqtmacvim.scpt and the 
" availability of osascript on the command line - as such, the plugin will only 
" work on relatively recent versions of Mac OS X.
" 
" Installation
" ------------
"
" 1. Place this file and ipyqtmacvim.scpt in ~/.vim/ftplugins/python
"
" 2. Place the following line in your .vimrc (requires MacVim 7.3)
" 		set clipboard=unnamed
"    This enables Vim to use your system clipboard.
"    
" 3. If desired, configure the hotkeys to run lines/selections or a file at the 
" bottom of this script (currently <Cmd-4> for lines and <Cmd-5> for the entire 
" file)
"
" Troubleshooting
" ---------------
"
" * If you find that the Python commands are typed in an unusual location (such 
" as back in your file in Vim), or that nothing appears to happen, then your 
" Mac is probably unable to switch focus from the MacVim window to the console 
" window fast enough before attempting to paste the appropriate text. To fix 
" this, open the ipyqtmacvim Applescript file and increase the delay values
" there.
"
" * Occasionally when opening a new Vim session, the very first sent line or 
" file name does not get sent properly to the Qt console. Subsequent commands 
" should work fine.
" 
" * Multi-line statements (other than those ending in 'return') will not 
" execute automatically and will remain until Enter is pressed one additional 
" time in the console. This is a known behavior.
"
" Contact
" -------
"
" Justin Kitzes at jkitzes@berkeley.edu


if !exists("*s:Send")
function s:Send ()
  execute "silent !osascript ~/.vim/ftplugin/python/ipyqtmacvim.scpt"
endfunction
endif

command -buffer         Send  call s:Send()


nmap <buffer> <D-4> yy:Send<CR>
vmap <buffer> <D-4> y:Send<CR>
imap <buffer> <D-4> <ESC>y:Send<CR>gi

nmap <buffer> <D-5> :let @*='run '.expand('%:p')<CR>:Send<CR>
imap <buffer> <D-5> <ESC>:let @*='run '.expand('%:p')<CR>:Send<CR>gi
