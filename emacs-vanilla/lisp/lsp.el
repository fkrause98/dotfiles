;;; package --- lsp mode settings
(use-package lsp-mode
  :defer t
  :ensure t
  :commands (lsp lsp-deferred)
  :config
  (lsp-enable-which-key-integration t))
(use-package lsp-ivy
  :defer t
  :commands lsp-ivy-workspace-symbol)
(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :config
 (setq lsp-ui-doc-position 'bottom))
