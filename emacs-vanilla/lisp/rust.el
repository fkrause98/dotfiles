;;; package --- Summary: Rust settings

(use-package rustic
  :straight t
  :mode ("\\.rs\\'" . rustic-mode)
  :config
  (setq-default rustic-format-on-save nil)
  (keys/local-leader
    :keymaps 'rustic-mode-map
    "f" '(rustic-format-buffer :which-key "rustic-format-buffer")
    "b" '(rustic-cargo-build :which-key "rustic-cargo-build")
    "c" '(rustic-cargo-check :which-key "rustic-cargo-check")))
