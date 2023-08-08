;;; mac.el -*- lexical-binding: t; -*-
;;; Get env from shell
(use-package exec-path-from-shell
  :defer t
  :straight t
  :init
  (when (memq window-system '(mac ns x))
	(exec-path-from-shell-initialize)))
;;; Shell to use
(setq shell-file-name "fish"
      vterm-shell "~/.nix-profile/bin/fish")
;;; Elixir
(setq elixir-ls-folder "~/elixir-ls")
;;; Modifiers
;; One thing that mac does well is
;; the command key, let's use it.
(setq mac-command-modifier 'control)
;; (setq mac-option-modifier 'meta)
(setq mac-right-option-modifier 'meta)
(setq mac-pass-command-to-system t)
(exec-path-from-shell-initialize)
;; (unless (boundp 'server-running-p)
;;     (server-start))

(defun funcs//insert-at-char ()
  (interactive)
  (insert 64))

;; (map! :i  "M-q" 'funcs//insert-at-char)
(display-battery-mode)
;; (push "~/.authinfo" auth-sources)
