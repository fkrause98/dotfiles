;;; package --- lsp mode settings
(use-package lsp-mode
  :defer t
  :straight t
  :hook (nix-mode rustic-mode elixir-mode)
  :commands (lsp lsp-deferred)
  :config
  (lsp-enable-which-key-integration t))
(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-doc-position 'bottom
        lsp-ui-sideline-delay 0.5
        lsp-ui-sideline-enable nil))
