_: {
  extraConfig = ''
    [merge]
      conflictstyle = diff3
    [pull]
      rebase = true
    [diff]
        tool = difftastic
    [difftool]
         prompt = false
    [difftool "difftastic"]
         cmd = difft "$LOCAL" "$REMOTE"
    [pager]
         difftool = true
  '';
  userEmail = "fkrausear@gmail.com";
  userName = "fkrause98";
}
