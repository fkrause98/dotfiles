_: {
  enable = true;
  userName = "fkrause98";
  extraConfig = {
    core = {
      pager = "delta";
    };

    interactive = {
      diffFilter = "delta --color-only";
    };

    delta = {
      navigate = "true";
      dark = "true";
    };

    merge = {
      conflictstyle = "zdiff3";
    };

    pull = {
      rebase = "true";
    };

    rebase = {
      autoSquash = "true";
      autoStash = "true";
      updateRefs = "true";
    };

    fetch = {
      prune = "true";
      pruneTags = "true";
      all = "true";
    };

    init = {
      defaultBranch = "main";
    };

    column = {
      ui = "auto";
    };

    branch = {
      sort = "-committerdate";
    };
  };
}
