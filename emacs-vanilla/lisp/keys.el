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
    "er" '(eval-region :which-key "Region"))
  ;;; Evil motion binds
  (general-create-definer keys/motion-state
    :prefix "g"
    :states 'motion)
  (keys/motion-state
    "cc" '(evilnc-comment-or-uncomment-lines :which-key "Comment line"))
  ;;; Git binds
  (keys/leader
    "g" '(:ignore t :which-key "Git")
    "gg" '(magit-status-quick :which-key "Status")
    "gc" '(magit-checkout :which-key "Checkout")
    "gb" '(magit-branch-create :which-key "Create branch")
    "gff" '(magit-find-file :which-key "Find file")
    "gku" '(smerge-keep-upper :which-key "Keep upper variant")
    "gkl" '(smerge-keep-lower :which-key "Keep lower variant"))
  ;;; Buffer keys
  (keys/leader
    "b" '(:ignore t :which-key "Buffer")
    "bb" '(counsel-ibuffer :which-key "Switch")
    "bk" '(kill-current-buffer :which-key "Kill current")
    "bl" '(evil-switch-to-windows-last-buffer :which-key "Latest buffer switch")
    "br" '(revert-buffer-with-fine-grain :which-key "Revert buffer"))
  ;;; Code keys
  (keys/leader
    "c"  '(:ignore t :which-key "Code")
    "cs" '(lsp-ivy-workspace-symbol :which-key "LSP Symbols")
    "cd" '(lsp-find-definition :which-key "Find definition")
    "cD" '(lsp-find-references :which-key "Find references")
    "cr" '(lsp-rename :which-key "Rename")
    "cx" '(counsel-flycheck :which-key "List errors"))
  ;;; File keys
  (keys/leader
    "f" '(:ignore t :which-key "Files")
    "ff" '(counsel-find-file :which-key "Find file")
    "fr" '(counsel-recentf :which-key "Recent files"))
  ;;; Helper keys
  (keys/leader
    "h" '(:ignore t :which-key "Help")
    "hf" '(helpful-callable :which-key "Describe function")
    "hk" '(helpful-key :which-key "Describe key")
    "hp" '(helpful-at-point :which-key "Help from text in point")
    "hv" '(counsel-describe-variable :which-key "Describe variable"))
  ;;; Project keys
  (keys/leader
    "p" '(:ignore t :which-key "Project")
    "pa" '(projectile-add-known-project :which-key "Add project folder")
    "pf" '(projectile-find-file :which-key "Find file")
    "pi" '(projectile-invalidate-cache :which-key "Add project folder")
    "pp" '(projectile-switch-project :which-key "Switch")
    "ps" '(counsel-projectile-rg :which-key "Search text"))
  ;;; Search keys
  (keys/leader
    "s" '(:ignore t :which-key "Search")
    "ss" '(swiper :which-key "Buffer"))
  ;;; Toggles
  (keys/leader
    "t"  '(:ignore t :which-key "Toggles")
    "tt" '(counsel-load-theme :which-key "Choose theme"))
  ;;; Window keys
  (keys/leader
    "w" '(:ignore t :which-key "Window")
    "ww" '(evil-window-next :which-key "Switch next")
    "wl" '(evil-window-left :which-key "Switch right")
    "wh" '(evil-window-right :which-key "Switch left")
    "wk" '(evil-window-up :which-key "Switch up")
    "wj" '(evil-window-down :which-key "Switch down")))
