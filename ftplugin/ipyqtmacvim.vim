"ipyqtmacvim - Plugin to send commands from MacVim to IPython Qt console
"
"Language:     Python
"Maintainer:   Justin Kitzes <jkitzes@berkeley.edu>
"License:      BSD New
"Requires:     MacVim 7.3, Mac OS X (osascript), IPython 0.12
"Last Change:  2012-03-17
"Version:      0.12
"
"Approximate the R or Matlab GUI experience using MacVim and IPython.
"
"This plugin provides the ability to run an entire file, a line, or
"highlighted text from MacVim directly in the IPython 0.12 Qt console. This is 
"intended to replicate the look and feel of integrated GUI environments such as 
"R for Mac OS X, in which a user has an open editor window next to a console 
"window, and within which a shortcut command will send lines or the entire file 
"from the editor window directly to the console window.
"
"ipyqtmacvim accomplishes this by copying the selection or file path to the 
"system clipboard, switching to the Python window, and pasting the command. 
"<Cmd-4> will run a single line (normal mode) or a selection (visual mode) and 
"<Cmd-5> will run the entire file (you can customize these hotkeys at the end 
"of this plugin).
"
"The plugin requires a companion Applescript file ipyqtmacvim.scpt and the 
"availability of osascript on the command line - as such, it will only work on 
"relatively recent versions of Mac OS X.
"
"See http://github.com/jkitzes/ipyqtmacvim/ for updates. 
"
"See also the excellent vim-ipython plugin by Paul Ivanov. ipyqtmacvim should 
"be preferred to vim-ipython only for users who are specifically looking to 
"replicate the feel of an R or Matlab GUI (and who use MacVim and IPython).
"
"Installation
"------------
"
"1. Place this file and ipyqtmacvim.scpt in ~/.vim/ftplugins/python
"
"2. Launch an IPython Qt console at the command line with "ipython qtconsole", 
"open a python file in MacVim, and use the hotkeys. Note that if you have 
"multiple Python windows open, the lines will be sent to the first that was 
"opened.
"
"Configuration
"-------------
"1. The hotkeys can be configured at the bottom of this script.
"
"2. The script can be configured to send lines to Terminal (or any other named 
"application) by changing the phrase <...whose name is "Python"> in the 
"Applescript to <...whose name is "Terminal">. This is handy for those who do 
"not want to use the Qt console. Note, however, that this will likely break the 
"ability to send multi-line statements (single lines and running the entire 
"file should work fine).
"
"Troubleshooting
"---------------
"
"* If you find that the Python commands are typed in an unusual location (such 
"as back in your file in Vim), or that nothing appears to happen, then your Mac 
"may be unable to switch focus from the MacVim window to the console window 
"fast enough before pasting. Open the ipyqtmacvim Applescript file and increase 
"the delay values there.
"
"* There may be a delay in sending the first command to the Python window. 
"Subsequent commands should work more quickly.
"
"* Multi-line statements (other than those ending in 'return') will not 
"execute automatically and will remain until Enter is pressed one additional 
"time in the console. This is a known behavior.
"
"Contact
"-------
"
"Justin Kitzes at jkitzes@berkeley.edu


if !exists("*s:Send")
function s:Send ()
  execute "silent !osascript ~/.vim/ftplugin/python/ipyqtmacvim.scpt"
endfunction
endif

command -buffer         Send  call s:Send()

" Command to send line or visual selection
nmap <buffer> <D-4> "+yy:Send<CR>
vmap <buffer> <D-4> "+y:Send<CR>
imap <buffer> <D-4> <ESC>"+yy:Send<CR>gi

" Command to run entire file
nmap <buffer> <D-5> :let @+='run '.expand('%:p')<CR>:Send<CR>
imap <buffer> <D-5> <ESC>:let @+='run '.expand('%:p')<CR>:Send<CR>gi
