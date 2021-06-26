# Defined via `source`
function preludenw --wraps='TERM=xterm-24bit emacs -nw --with-profile prelude' --description 'alias emacsnw=TERM=xterm-24bit emacs -nw --with-profile prelude'
  TERM=xterm-24bit emacs -nw --with-profile prelude $argv; 
end
