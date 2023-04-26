;;; ../emacs-doom-config/elixir.el -*- lexical-binding: t; -*-
;; Check if I have the elixir language server
;; locally installed.
;; To run tests with seed 0
;; (setq alchemist-mix-test-default-options '("--seed 0" "--trace"))

;; Add elixir to doom's autoformat on save languages
(setq +format-on-save-enabled-modes
      '(t elixir-mode))
;; Disable for reasons I don't remember
(setq alchemist-mix-test-default-options nil)

(defun my-elixir-hooks ()
  (setq company-idle-delay 0.2
        yas-also-auto-indent-first-line t)
  ;; Company can be a bit annoying with its
  ;; suggestions, as the default value
  ;;  of this variable is 2.
  (setq-local company-minimum-prefix-length 3)
  (mix-minor-mode)
  (lsp-lens--hide))
;; Show which function I'm visiting in the modeline
;; (add-hook 'elixir-mode-hook 'which-function-mode)
(add-hook 'elixir-mode-hook 'elixir/variables-hook)
(add-hook 'elixir-mode-hook 'which-function-mode)
;; Workaround to enable running credo after lsp
(defvar-local my/flycheck-local-cache nil)
(defun my/flycheck-checker-get (fn checker property)
  (or (alist-get property (alist-get checker my/flycheck-local-cache))
      (funcall fn checker property)))
(advice-add 'flycheck-checker-get :around 'my/flycheck-checker-get)
(add-hook 'lsp-managed-mode-hook
          (lambda ()
            (when (derived-mode-p 'elixir-mode)
              (setq my/flycheck-local-cache '((lsp . ((next-checkers . (elixir-credo)))))))))
(add-hook 'elixir-mode #'my-elixir-hooks)
