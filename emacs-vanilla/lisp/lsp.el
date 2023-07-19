;;; package --- lsp mode settings
(use-package lsp-mode
  :defer t
  :straight t
  :hook ((nix-mode rustic-mode elixir-mode) . lsp)
  :commands (lsp lsp-deferred)
  :config
  (lsp-enable-which-key-integration t)
  (setq lsp-lens-enable t
        lsp-elixir-local-server-command  (expand-file-name "~/.nix-profile/bin/elixir-ls")))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-doc-position 'bottom
        lsp-ui-sideline-delay 0.5
        lsp-ui-sideline-enable nil))

