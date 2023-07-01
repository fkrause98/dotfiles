;;; package --- Summary: Elixir settings

(use-package elixir-mode
  :mode (("\\.ex\\'" . elixir-mode)
	 ("\\.exs\\'" . elixir-mode)))

(use-package mix
  :after elixir-mode
  :hook (elixir-mode 'mix-minor-mode)
  :config
  (setq compilation-scroll-output 'first-error))

(with-eval-after-load "keys"
  (keys/local-leader
    :keymaps 'elixir-mode-map
    "m" '(:ignore t :which-key "Mix")
    "f" '(elixir-format :which-key "Format")
    "mt" '(:ignore t :which-key "Test")
    "tt" '(mix-test-current-test :which-key "At point")
    "tb" '(mix-test-current-buffer :which-key "Current buffer")))
