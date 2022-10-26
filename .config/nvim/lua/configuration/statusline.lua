vim.cmd(
  [[
set statusline=
set statusline+=%f   " Path to the file
set statusline+=%w   " If we are in a preview window
set statusline+=%r   " Readonly flag
set statusline+=%m   " Modified flag
set statusline+=%=   " Switch to the right side
set statusline+=%{FugitiveStatusline()}
set statusline+=\    " Whitespace
set statusline+=%l   " Current line
set statusline+=/    " Separator
set statusline+=%L   " Total lines
set statusline+=%c   " column
]]
)
