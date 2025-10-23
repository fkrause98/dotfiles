_: {
  enable = true;
  settings = { ignorecase = true; };
  extraConfig = ''
    set mouse=a
     set nu
     set rnu
     set expandtab
     set tabstop=2
     set softtabstop=2
     set shiftwidth=2
     " Remember last position on file
    if has("autocmd")
      augroup redhat
      autocmd!
      " When editing a file, always jump to the last cursor position
      autocmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \   exe "normal! g'\"" |
        \ endif
      augroup END
    endif
  '';
}
