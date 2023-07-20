;;; package --- Summary: Elixir settings
(use-package elixir-mode
  :mode
  (("\\.ex\\'" . elixir-mode)
	 ("\\.exs\\'" . elixir-mode))
  :hook
  (elixir-mode . aggressive-indent-mode)
  :config
  ;; (add-hook 'elixir-mode-hook  'elixir/hooks))
  )

;;;###autoload
(defun elixir/hooks nil
  (add-hook 'before-save-hook 'elixir/before-save-hook))
;;;###autoload
(defun elixir/before-save-hook nil
  (when (eq major-mode 'elixir-mode)
    (elixir-format)))

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

(use-package polymode
  :mode
  (("\\.ex\\'" . poly-elixir-web-mode)
	 ("\\.exs\\'" . poly-elixir-web-mode))
  :config
  (define-hostmode poly-elixir-hostmode :mode 'elixir-mode)
  (define-innermode poly-liveview-expr-elixir-innermode
    :mode 'web-mode
    :head-matcher (rx line-start (* space) "~H" (= 3 (char "\"'")) line-end)
    :tail-matcher (rx line-start (* space) (= 3 (char "\"'")) line-end)
    :head-mode 'host
    :tail-mode 'host
    :allow-nested nil
    :keep-in-mode 'host
    :fallback-mode 'host)
  (define-polymode poly-elixir-web-mode
    :hostmode 'poly-elixir-hostmode
    :innermodes '(poly-liveview-expr-elixir-innermode)))

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

;;; Taken from this gist:
;;; https://gist.githubusercontent.com/victorolinasc/fa44dcb6e05b3a4bb33b033bfb3da414
(use-package reformatter
  :ensure t
  :after (elixir-mode)
  :config
  ; Adds a reformatter configuration called "+elixir-format"
  ; This uses "mix format -"
  (reformatter-define +elixir-format
    :program "mix"
    :args '("format" "-"))
  ; defines a function that looks for the .formatter.exs file used by mix format
  (defun +set-default-directory-to-mix-project-root (original-fun &rest args)
    (if-let* ((mix-project-root (and buffer-file-name
                                     (locate-dominating-file buffer-file-name
                                                             ".formatter.exs"))))
        (let ((default-directory mix-project-root))
          (apply original-fun args))
      (apply original-fun args)))
  ; adds an advice to the generated function +elxir-format-region that sets the proper root dir
  ; mix format needs to be run from the root directory otherwise it wont use the formatter configuration
  (advice-add '+elixir-format-region :around #'+set-default-directory-to-mix-project-root)
  ; Adds a hook to the major-mode that will add the generated function +elixir-format-on-save-mode
  ; So, every time we save an elixir file it will try to find a .formatter.exs and then run mix format from
  ; that file's directory
  (add-hook 'elixir-mode-hook #'+elixir-format-on-save-mode))
