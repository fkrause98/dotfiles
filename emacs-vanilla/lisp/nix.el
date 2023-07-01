;;; package --- Nix settings
(use-package nix-mode
  :straight t
  :mode "\\.nix\\'")
(with-eval-after-load "keys"
  (keys/local-leader
    :keymaps 'nix-mode-map
    "f" '(nix-format-buffer :which-key "Format current buffer")))
