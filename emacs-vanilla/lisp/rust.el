;;; package --- Summary: Rust settings

(use-package rustic
  :straight t
  :mode ("\\.rs\\'" . rustic-mode)
  :bind (:map rustic-mode-map
              ("M-j" . lsp-ui-imenu)
              ("M-?" . lsp-find-references)
              ("C-c C-c l" . flycheck-list-errors)
              ("C-c C-c a" . lsp-execute-code-action)
              ("C-c C-c r" . lsp-rename)
              ("C-c C-c q" . lsp-workspace-restart)
              ("C-c C-c Q" . lsp-workspace-shutdown)
              ("C-c C-c s" . lsp-rust-analyzer-status))
  :config
  (setq rustic-format-on-save t)
  (keys/local-leader
    :keymaps 'rustic-mode-map
    "f" '(rustic-format-buffer :which-key "rustic-format-buffer")
    "b" '(rustic-cargo-build :which-key "rustic-cargo-build")
    "c" '(rustic-cargo-check :which-key "rustic-cargo-check")))
