# Defined via `source`
function emacsnw --wraps='TERM=xterm-24bit emacs -nw' --description 'alias emacsnw=TERM=xterm-24bit emacs -nw'
  TERM=xterm-24bit emacs -nw $argv; 
end
