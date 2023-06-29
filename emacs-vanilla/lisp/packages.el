;;; package -- Some non-related (between them) packages
(use-package rainbow-delimiters
  :straight t
  :hook (prog-mode . rainbow-delimiters-mode))
(use-package helpful
  :straight t
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-function-variable #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
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
  :hook
  ((python-mode . highlight-indent-guides-mode)
   (elixir-mode . highlight-indent-guides-mode)
   (rust-mode . highlight-indent-guides-mode)
   (csharp-tree-sitter-mode . highlight-indent-guides-mode))
  :config
  (setq highlight-indent-guides-method 'character))

;; Despite what its name implies,
;; it also works on wayland and mac.
(use-package xclip
  :straight t
  :config
  (unless *is-mac*
    (setq xclip-method 'wl-copy)))

(use-package clipetty
  :straight t)

(use-package sudo-edit
  :defines (sudo-edit sudo-edit-find-file)
  :straight t)

(use-package blamer
  :straight t
  :commands (blamer-mode global-blamer-mode)
  :defer 20
  :custom
  (blamer-idle-time 0.3)
  (blamer-min-offset 70)
  :custom-face
  (blamer-face ((t :foreground "#7a88cf"
                    :background nil
                    :height 140
                    :italic t))))
(use-package fish-mode
  :straight t
  :mode ("\\.fish\\'" . fish-mode))
