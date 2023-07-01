;;; package --- Summary: Rust settings

(use-package rustic
  :straight t
  :mode ("\\.rs\\'" . rustic-mode)
  :config
  (setq-default rustic-format-on-save nil))
(with-eval-after-load "keys"
  (keys/local-leader
    :keymaps 'rustic-mode-map
    "b" '(rustic-cargo-build :which-key "rustic-cargo-build")
    "c" '(rustic-cargo-check :which-key "rustic-cargo-check")
    "f" '(lsp-format-buffer :which-key "Format buffer")))
