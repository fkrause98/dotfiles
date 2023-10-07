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


(use-package flycheck
  :hook (lsp-mode . flycheck-mode)
  :config
  (global-flycheck-mode))

(setq undo-tree-auto-save-history t
      undo-tree-history-directory-alist '(("." . "~/.emacs-undo")))

(use-package undo-tree
  :after evil-mode
  :commands (turn-on-undo-tree-mode global-undo-tree-mode undo-tree-mode))
(use-package neotree
  :straight t
  :after projectile)


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

(use-package aggressive-indent
  :straight t
  :commands (aggressive-indent-mode))

(use-package ranger
  :commands (ranger)
  :config
  (with-eval-after-load "keys"
    (keys/leader
      "od" '(ranger :which-key "Dired")))
  (setq ranger-dont-show-binary t
        ranger-show-literal nil))

(use-package wgrep
  :commands (wgrep-change-to-wgrep-mode)
  :config
  (setq wgrep-change-readonly-file t))



(use-package yul-mode
  :mode
  (("\\.yul\\'" . yul-mode))
  :config
  (add-hook 'yul-mode-hook
            (lambda ()
              (setq indent-line-function 'indent-relative))))

(use-package string-inflection
  :commands (string-inflection-java-style-cycle))
