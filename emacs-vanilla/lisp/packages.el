;;; package -- Some non-related (between them) packages
(use-package rainbow-delimiters
  :straight t
  :hook (prog-mode . rainbow-delimiters-mode))
(use-package helpful
  :straight t
  :after consult
  ;; :custom
  ;; (counsel-describe-function-function #'helpful-callable)
  ;; (counsel-describe-function-variable #'helpful-variable)
  :bind
  ([remap describe-function] . consult-describe-function)
  ([remap describe-command] . consult-describe-command)
  ([remap describe-variable] . consult-describe-variable)
  ([remap describe-key] . helpful-key))
(use-package smartparens
  :straight t
  :hook (prog-mode . smartparens-mode)
  :config
  (require 'smartparens-config)
  (smartparens-global-mode)
  ;; Rules to add new lines after brackets and parens
  (sp-pair "{" nil :post-handlers '(("||\n[i]" "RET")))
  (sp-pair "[" nil :post-handlers '(("||\n[i]" "RET")))
  (sp-pair "(" nil :post-handlers '(("||\n[i]" "RET"))))

;;; Tame emacs pop buffers!
(use-package popper
  :straight t 
  :bind (("C-`"   . popper-toggle-latest)
         ("M-`"   . popper-cycle)
         ("C-M-`" . popper-toggle-type))
  :init
  (setq popper-reference-buffers
         ; Make some buffers toggable
        '("\\*Messages\\*"
          "Output\\*$"
          "\\*Async Shell Command\\*"
          "\\*Warnings\\*"
          ;; "^\\*vterm.*\\*$"
          "\\*rustic-compilation\\*"
          help-mode
          compilation-mode
          rustic-compilation-mode))
  (setq popper-window-height 20)
  (popper-mode +1)
  (popper-echo-mode +1))                ; For echo area hints

(use-package flycheck
  :hook (lsp-mode . flycheck-mode)
  :config
  (global-flycheck-mode))

(use-package undo-fu
  :after evil-mode)
(use-package undo-fu-session
  :after undo-fu
  :config
  (undo-fu-session-global-mode))
(use-package neotree
  :straight t
  :after projectile)

(use-package doom-modeline
  :straight t
  :config
  (setq doom-modeline-icon nil)
  (doom-modeline-mode 1))

(use-package highlight-indent-guides
  :straight t
  ;; :hook
  ;; ((python-mode . highlight-indent-guides-mode)
  ;;  (elixir-mode . highlight-indent-guides-mode)
  ;;  (rust-mode . highlight-indent-guides-mode)
  ;;  (csharp-tree-sitter-mode . highlight-indent-guides-mode))
  :config
  (setq highlight-indent-guides-method 'character))

;; Despite what its name implies,
;; it also works on wayland and mac.
(use-package xclip
  :straight t
  :commands (xclip-mode)
  :hook (after-init . xclip-mode))

(use-package sudo-edit
  :commands (sudo-edit sudo-edit-find-file)
  :defines (sudo-edit sudo-edit-find-file)
  :straight t)

(use-package fish-mode
  :straight t
  :mode ("\\.fish\\'" . fish-mode))

(use-package direnv
  :after projectile
  :straight t
  :config
  (setq direnv-always-show-summary nil)
  (direnv-mode))
(use-package exec-path-from-shell
  :if *is-mac*
  :straight t
  :config
  (exec-path-from-shell-initialize))
