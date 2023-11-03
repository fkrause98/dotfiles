;;; package -- Some general keybinds
(use-package which-key
  :straight t
  :hook (after-init . which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-sort-order #'which-key-key-order-alpha
        which-key-sort-uppercase-first nil
        which-key-add-column-padding 1
        which-key-max-display-columns nil
        which-key-min-display-lines 6
        which-key-side-window-slot -10
        which-key-idle-delay 0.3))
(use-package general
  :straight t
  :config
  (general-create-definer keys/leader
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "C-SPC")
  (general-create-definer keys/local-leader
    :states '(normal insert visual emacs)
    :which-key "Local leader"
    :prefix "SPC m"
    :global-prefix "C-SPC m"
    "" '(:ignore t :which-key "Local leader"))
  ;;; Emacs lisp mode keybinds
  (keys/local-leader
    :keymaps 'emacs-lisp-mode-map
    "e" '(:ignore t :which-key "Eval")
    "ee" '(eval-last-sexp :which-key "Last sexp")
    "eb" '(eval-buffer :which-key "Buffer")
    "er" '(eval-region :which-key "Region")
    "p" '(check-parens :which-key "Check parens balance")
    "h" '(:ignore t :which-key "Help")
    "hp" '(helpful-at-point :which-key "Help from text in point"))
  (keys/leader
    "h" '(:ignore t :which-key "Help")
    "hf" '(helpful-callable :which-key "Describe function")
    "hk" '(helpful-key :which-key "Describe key")
    "hv" '(helpful-variable :which-key "Describe variable")
    "hp" '(helpful-at-point :which-key "Describe variable"))
  ;;; Evil motion keybinds
  (general-create-definer keys/motion-state
    :prefix "g"
    :states 'motion)
  (keys/motion-state
    "cc" '(evilnc-comment-or-uncomment-lines :which-key "Comment line"))
  ;;; Commands that open special new buffers
  (keys/leader
    "o" '(:ignore t :which-key "Open")
    "od" '(dired-jump :which-key "Dired")
    "ot" '(vterm :which-key "Terminal")
    "oe" '(eshell :which-key "Eshell")
    "op" '(neotree-projectile-action :which-key "Tree file"))
  ;;; Git binds
  (keys/leader
    "g" '(:ignore t :which-key "Git")
    "gg" '(magit-project-status :which-key "Status")
    "gc" '(magit-checkout :which-key "Checkout")
    "gC" '(smerge-vc-next-conflict :which-key "Next Conflict")
    "gb" '(magit-branch-create :which-key "Create branch")
    "gp" '(magit-pull :which-key "Pull")
    "gm" '(magit-merge :which-key "Merge")
    "gff" '(magit-find-file :which-key "Find file")
    "gku" '(smerge-keep-upper :which-key "Keep upper variant")
    "gkb" '(smerge-keep-all :which-key "Keep both variants")
    "gkl" '(smerge-keep-lower :which-key "Keep lower variant"))
  ;;; Buffer keys
  (keys/leader
    "b" '(:ignore t :which-key "Buffer")
    "bb" '(buffers/switch-project-buffer :which-key "Switch")
    "bB" '(buffers/switch-buffer :which-key "Switch")
    "bk" '(kill-current-buffer :which-key "Kill current")
    "bl" '(evil-switch-to-windows-last-buffer :which-key "Latest buffer switch")
    "br" '(funs/revert-buffer-no-confirm :which-key "Revert buffer")
    "br" '(revert-buffer-with-fine-grain :which-key "Revert buffer")
    "bn" '(evil-buffer-new :which-key "New buffer"))
  ;;; Code keys
  (keys/leader
    "c"  '(:ignore t :which-key "Code")
    "ca" '(lsp-execute-code-action :which-key "LSP Code Action")
    "cs" '(consult-lsp-file-symbols :which-key "LSP symbols")
    "cw" '(consult-lsp-symbols :which-key "LSP Workspace symbols")
    "cd" '(code/find-definition :which-key "Find definition")
    "cD" '(code/find-references :which-key "Find references")
    "cr" '(lsp-rename :which-key "Rename")
    "cx" '(code/show-errors :which-key "List errors")
    "ch" '(lsp-describe-thing-at-point :which-key "Help"))
  ;;; File keys
  (keys/leader
    "f" '(:ignore t :which-key "Files")
    "ff" '(find-file :which-key "Find file")
    "fr" '(files/recent :which-key "Recent files")
    "fd" '(files/delete-this-file :which-key "Delete this file")
    "fs" '(files/sudo-this-file :which-key "Open this file as sudo")
    "fp" '(find-file-at-point :which-key "File at point")
    "fy" '(evil/yank-file-name :which-key "Copy file path")
    "fd" '(files/delete-this-file :which-key "Delete this file"))
  ;;; Search keys
  (keys/leader
    "s" '(:ignore t :which-key "Search")
    "ss" '(search/search-current-buffer :which-key "Buffer")
    "si" '(consult-imenu-multi :which-key "Imenu")
    "sj" '(evil-collection-consult-jump-list :which-key "Jump list"))
  ;;; Toggles
  (keys/leader
    "t"  '(:ignore t :which-key "Toggles")
    "tt" '(consult-theme :which-key "Choose theme"))
  ;;; Window keys
  (keys/leader
    "w" '(:ignore t :which-key "Window")
    "ww" '(evil-window-next :which-key "Switch next")
    "wl" '(evil-window-right :which-key "Switch right")
    "wh" '(evil-window-left :which-key "Switch left")
    "wk" '(evil-window-up :which-key "Switch up")
    "wj" '(evil-window-down :which-key "Switch down")
    "wL" '(evil-window-move-far-right :which-key "Switch right")
    "wH" '(evil-window-move-far-left :which-key "Switch left")
    "wK" '(evil-window-move-very-top :which-key "Switch up")
    "wJ" '(evil-window-move-very-bottom :which-key "Switch down")
    "w=" '(balance-windows :which-key "Balance windows")
    "wm" '(maximize-window :which-key "Maximize focused window"))
  ;;; Insert text
  (keys/leader
    "i" '(:ignore t :which-key "Insert")
    "ik" '(consult-yank-from-kill-ring :which-key "From kill-ring"))
;;; Project keybinds
(keys/leader
    "p" '(:ignore t :which-key "Project")
    "pa" '(projectile-add-known-project :which-key "Add project folder")
    "pf" '(project-find-file :which-key "Find file")
    "pi" '(projectile-invalidate-cache :which-key "Add project folder")
    "pp" '(project/switch-to-project :which-key "Switch")
    "pr" '(projectile-recentf  :which-key "Switch")
    "ps" '(search/project-text-search :which-key "Search text")
    "pr" '(project/run-project :which-key "Run project")
    "pc" '(projectile-compile-project :which-key "Compile project")))

(defmacro generate-tab-switching-commands (n prefix)
  (let ((code '()))
    (dotimes (i n)
      (push `(general-define-key
               :keymaps 'override
               ,(format "%s-%d" prefix (1+ i))
               (lambda ()
                 (interactive)
                 (tab-bar-select-tab ,(+ i 1))))
            code))
    `(progn ,@code)))

(if *is-mac*
    (generate-tab-switching-commands 5 "C")
    (generate-tab-switching-commands 5 "M"))

