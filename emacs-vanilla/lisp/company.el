;;; package --- Company (autocomplete) settings
(use-package company
  :straight t
  :after (lsp-mode)
  :commands (company-mode)
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
         ("<tab>" . company-indent-or-complete-common))
  :config
  (global-company-mode 1)
  :custom
  (company-minimum-prefix-length 3)
  (company-idle-delay 0.0))
(use-package company-box
  :if (display-graphic-p)
  :commands (company-box-mode)
  :straight t
  :after company
  :hook (company-mode . company-box-mode))
;; TODO:
;; Put this under the use-package definition,
;; for some reason it didn't work when I
;; tried with :hook and :after.
(add-hook 'prog-mode-hook #'company-mode)
