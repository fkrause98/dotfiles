;;; package --- Summary: Elixir settings
(use-package elixir-mode
  :mode
  (("\\.ex\\'" . elixir-mode)
	 ("\\.exs\\'" . elixir-mode)))

(use-package exunit
  :commands
  (exunit-verify-all
   exunit-verify-all-in-umbrella
   exunit-verify
   exunit-verify-single
   exunit-rerun
   exunit-toggle-file-and-test
   exunit-debug
   exunit-toggle-file-and-test-other-window))

;; (use-package polymode
;;   :mode
;;   (("\\.ex\\'" . poly-elixir-web-mode)
;; 	 ("\\.exs\\'" . poly-elixir-web-mode))
;;   ;; :hook (elixir-mode)
;;   :config
;;   (define-hostmode poly-elixir-hostmode :mode 'elixir-mode)
;;   (define-innermode poly-liveview-expr-elixir-innermode
;;     :mode 'web-mode
;;     :head-matcher (rx line-start (* space) "~H" (= 3 (char "\"'")) line-end)
;;     :tail-matcher (rx line-start (* space) (= 3 (char "\"'")) line-end)
;;     :head-mode 'host
;;     :tail-mode 'host
;;     :allow-nested nil
;;     :keep-in-mode 'host
;;     :fallback-mode 'host)
;;   (define-polymode poly-elixir-web-mode
;;     :hostmode 'poly-elixir-hostmode
;;     :innermodes '(poly-liveview-expr-elixir-innermode)))
(with-eval-after-load "keys"
  (keys/local-leader
    :keymaps 'elixir-mode-map
    "f" '(elixir-format :which-key "Format")
    "t" '(:ignore t :which-key "Test")
    "ta" '(exunit-verify-all :which-key "Every test")
    "tb" '(exunit-verify :which-key "Current buffer")
    "td" '(exunit-debug :which-key "Debug")
    "tr" '(exunit-debug :which-key "Re-run")
    "tt" '(exunit-verify-single :which-key "At point")))
