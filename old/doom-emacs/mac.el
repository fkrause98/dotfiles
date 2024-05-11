;;; mac.el -*- lexical-binding: t; -*-
;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (when (display-graphic-p)
(setq doom-font
      (font-spec
       :family
       (cond
        ((member "Monaco" (font-family-list)) "Monaco")
        ((member "SF Mono" (font-family-list)) "SF Mono")
        ((member "JetBrains Mono" (font-family-list)) "JetBrains Mono")
        ((member "Fira Code" (font-family-list)) "Fira Code"))
       :size 12))
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

(map! :i  "M-q" 'funcs//insert-at-char)
(display-battery-mode)
(set-lookup-handlers! 'nasm-mode
  :definition 'x86-lookup)
(setq inferior-lisp-program "sbcl")

(push "~/.authinfo" auth-sources)
