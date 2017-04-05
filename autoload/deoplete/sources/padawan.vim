" Padawan server control
"
if (get(g:, 'deoplete#sources#padawan#loaded', 0))
  finish
endif

let s:plugin_directory = expand('<sfile>:p:h:h:h:h')

let g:deoplete#sources#padawan#loaded = 1

let lib_path = expand('<sfile>:p:h:h:h:h') . '/rplugin/python3/deoplete/sources/deoplete_padawan'

let g:deoplete#sources#padawan#server_addr =
      \ get(g:, 'deoplete#sources#padawan#server_addr', 'http://127.0.0.1:15155')
let g:deoplete#sources#padawan#server_command =
      \ get(g:, 'deoplete#sources#padawan#server_command', 'padawan-server')
let g:deoplete#sources#padawan#log_file =
      \ get(g:, 'deoplete#sources#padawan#log_file', '/tmp/padawan-server.log')

let g:deoplete#sources#padawan#server_autostart =
      \ get(g:, 'deoplete#sources#padawan#server_autostart', 1)
let g:deoplete#sources#padawan#add_parentheses =
      \ get(g:, 'deoplete#sources#padawan#add_parentheses', 0)
let g:deoplete#sources#padawan#auto_update =
      \ get(g:, 'deoplete#sources#padawan#auto_update', 0)

python3 << PYTHON
import vim
import sys
import os

lib_path = vim.eval('lib_path')
sys.path.insert(0, os.path.join(lib_path))

import padawan_server

server_addr = vim.eval('g:deoplete#sources#padawan#server_addr')
server_command = vim.eval('g:deoplete#sources#padawan#server_command')
log_file = vim.eval('g:deoplete#sources#padawan#log_file')

_padawan_server = padawan_server.Server(server_addr, server_command, log_file)
PYTHON

function! deoplete#sources#padawan#InstallServer()
  exec "!cd " . s:plugin_directory . " && composer install"
endfunction

function! deoplete#sources#padawan#UpdateServer()
  exec "!cd " . s:plugin_directory . " && composer update"
endfunction

function! deoplete#sources#padawan#StartServer()
  " @todo - add some feedback with information if started
  python3 _padawan_server.start()
endfunction

function! deoplete#sources#padawan#StopServer()
  " @todo - add some feedback with information if stoped
  python3 _padawan_server.stop()
endfunction

function! deoplete#sources#padawan#RestartServer()
  " @todo - add some feedback with information if restarted
  python3 _padawan_server.restart()
endfunction
