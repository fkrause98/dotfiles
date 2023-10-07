;;; package --- Summary: Rust settings

(use-package rustic
  :straight t
  :mode ("\\.rs\\'" . rustic-mode)
  :config
  (setq-default rustic-format-on-save nil)
  (setq-default rustic-default-test-arguments "--benches --tests --all-features -- --nocapture")
  (add-hook 'rustic-compilation-mode-hook 'rustic-compilation-mode-hook-setup))

(defun rustic-compilation-mode-hook-setup ()
  (setq compilation-scroll-output 'first-error))

(with-eval-after-load "keys"
  (keys/local-leader
    :keymaps 'rustic-mode-map
    "b" '(rustic-cargo-build :which-key "rustic-cargo-build")
    "c" '(rustic-cargo-check :which-key "rustic-cargo-check")
    "f" '(lsp-format-buffer :which-key "Format buffer")
    "r" '(rustic-cargo-run :which-key "Cargo run")
    "t" '(:ignore t :which-key "Test")
    "tt" '(rustic-cargo-current-test :which-key "Point")
    "ta" '(rustic-cargo-current-test :which-key "Everything")))
