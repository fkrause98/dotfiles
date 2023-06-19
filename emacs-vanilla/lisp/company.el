;;; package --- Company (autocomplete) settings
(use-package company
  :commands (company-mode)
  :after (lsp-mode)
  :hook ((lsp-mode emacs-lisp-mode) . company-mode)
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
         ("<tab>" . company-indent-or-complete-common))
  :config
  (global-company-mode 1)
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))
(use-package company-box
  :after company
  :hook (company-mode . company-box-mode))
