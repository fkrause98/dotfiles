;;; package -- Some general keybinds
(use-package general
  :straight t
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
  (keys/local-leader
    :keymaps 'rustic-mode-map
    "f" '(lsp-format-buffer :which-key "Format buffer"))
  ;;; Evil motion binds
  (general-create-definer keys/motion-state
    :prefix "g"
    :states 'motion)
  (keys/motion-state
    "cc" '(evilnc-comment-or-uncomment-lines :which-key "Comment line"))
  ;;; Commands that open special new buffers
  (keys/leader
    "o" '(:ignore t :which-key "Open")
    "ot" '(vterm :which-key "Terminal"))
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
    "bb" '(buffers/switch-project-buffer :which-key "Switch")
    "bB" '(buffers/switch-buffer :which-key "Switch")
    "bk" '(kill-current-buffer :which-key "Kill current")
    "bl" '(evil-switch-to-windows-last-buffer :which-key "Latest buffer switch")
    "br" '(funcs/revert-buffer-no-confirm :which-key "Revert buffer")
    "br" '(revert-buffer-with-fine-grain :which-key "Revert buffer")
    "bn" '(evil-buffer-new :which-key "New buffer"))
  ;;; Code keys
  (keys/leader
    "c"  '(:ignore t :which-key "Code")
    "cs" '(consult-lsp-file-symbols :which-key "LSP symbols")
    "cw" '(consult-lsp-symbols :which-key "LSP Workspace symbols")
    "cd" '(lsp-find-definition :which-key "Find definition")
    "cD" '(lsp-find-references :which-key "Find references")
    "cr" '(lsp-rename :which-key "Rename")
    "cx" '(consult-lsp-diagnostics :which-key "List errors")
    "cx" '(counsel-flycheck :which-key "List errors")
    "ch" '(lsp-describe-thing-at-point :which-key "Help"))
  ;;; File keys
  (keys/leader
    "f" '(:ignore t :which-key "Files")
    "ff" '(find-file :which-key "Find file")
    "fr" '(files/recent :which-key "Recent files")
    "fd" '(files/delete-this-file :which-key "Delete this file")
    "fs" '(files/sudo-this-file :which-key "Open this file as sudo"))
    "fp" '(find-file-at-point :which-key "File at point"))
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
    "pf" '(consult-projectile-find-file  :which-key "Find file")
    "pi" '(projectile-invalidate-cache :which-key "Add project folder")
    "pp" '(consult-projectile-switch-project :which-key "Switch")
    "pr" '(projectile-recentf  :which-key "Switch")
    "ps" '(search/project-text-search :which-key "Search text"))
  ;;; Search keys
  (keys/leader
    "s" '(:ignore t :which-key "Search")
    "ss" '(search/search-current-buffer :which-key "Buffer")
    "si" '(imenu :which-key "Imenu"))
  ;;; Toggles
  (keys/leader
    "t"  '(:ignore t :which-key "Toggles")
    "tt" '(consult-theme :which-key "Choose theme"))
  ;;; Window keys
  (keys/leader
    "w" '(:ignore t :which-key "Window")
    "ww" '(evil-window-next :which-key "Switch next")
    "wl" '(evil-window-left :which-key "Switch right")
    "wh" '(evil-window-right :which-key "Switch left")
    "wk" '(evil-window-up :which-key "Switch up")
    "wj" '(evil-window-down :which-key "Switch down")))
