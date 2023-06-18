;;; package -- Some keybinds
(use-package general
  :config
  (general-create-definer keys/leader
    :states '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")
  (general-create-definer keys/local-leader
    :states '(normal insert visual emacs)
    :prefix "SPC m"
    :global-prefix "C-SPC m")
  (keys/local-leader
    :keymaps 'emacs-lisp-mode-map
    "e" '(:ignore t :which-key "Eval")
    "ee" '(eval-last-sexp :which-key "Last sexp")
    "eb" '(eval-buffer :which-key "Buffer")
    "er" '(eval-buffer :which-key "Region"))
  (general-create-definer keys/motion-state
    :prefix "g"
    :states 'motion)
  (keys/motion-state
    "cc" '(evilnc-comment-or-uncomment-lines :which-key "Comment line"))
  (keys/leader
    "g" '(:ignore t :which-key "Git")
    "gg" '(magit-status-quick :which-key "Status"))
  (keys/leader
    "bb" '(counsel-ibuffer :which-key "Switch")
    "bk" '(kill-current-buffer :which-key "Kill current")
    "bl" '(evil-switch-to-windows-last-buffer :which-key "Latest buffer switch")
    "br" '(revert-buffer-with-fine-grain :which-key "Revert buffer")
    "cs" '(lsp-ivy-workspace-symbol :which-key "LSP Symbols")
    "cd" '(lsp-find-definition :which-key "Find definition")
    "cD" '(lsp-find-references :which-key "Find references")
    "cr" '(lsp-rename :which-key "Rename")
    "cx" '(counsel-flycheck :which-eky "List errors")
    "f" '(:ignore t :which-key "Files")
    "ff" '(counsel-find-file :which-key "Find file")
    "fr" '(counsel-recentf :which-key "Recent files")
    "h" '(:ignore t :which-key "Help")
    "hf" '(helpful-callable :which-key "Describe function")
    "hk" '(helpful-key :which-key "Describe key")
    "hp" '(helpful-at-point :which-key "Help from text in point")
    "hv" '(counsel-describe-variable :which-key "Describe variable")
    "p" '(:ignore t :which-key "Project")
    "pa" '(projectile-add-known-project :which-key "Add project folder")
    "pf" '(projectile-find-file :which-key "Find file")
    "pi" '(projectile-invalidate-cache :which-key "Add project folder")
    "pp" '(projectile-switch-project :which-key "Switch")
    "ps" '(counsel-projectile-rg :which-key "Search text")
    "s" '(:ignore t :which-key "Search")
    "ss" '(swiper :which-key "Buffer")
    "t"  '(:ignore t :which-key "Toggles")
    "tt" '(counsel-load-theme :which-key "Choose theme")
    "w" '(:ignore t :which-key "Window")
    "ww" '(evil-window-next :which-key "Switch other")))
