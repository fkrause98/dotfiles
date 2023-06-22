;;; Load package manager config
(load "~/.emacs.d/lisp/package-manager-settings")
;;; Better GC for Emacs
(load "~/.emacs.d/lisp/garbage-collection")
;;; Custom funcs
(load "~/.emacs.d/lisp/custom-funcs")
;;; Load editor settings
(load "~/.emacs.d/lisp/settings")
;;; Load some libs
(load "~/.emacs.d/lisp/utils")
;;; Interactive text sorting and filtering
(load "~/.emacs.d/lisp/ivy-counsel-swiper")
(load "~/.emacs.d/lisp/vertico")
;;; Customized sorting
(load "~/.emacs.d/lisp/prescient")
;;; Some non-ated (between them) packages
(load "~/.emacs.d/lisp/packages")
;;; A proper editor for Emacs
(load "~/.emacs.d/lisp/evil")
;;; General keybinds
(load "~/.emacs.d/lisp/keys")
;;; Project management
(load "~/.emacs.d/lisp/project")
;;; Git management
(load "~/.emacs.d/lisp/git")
;;; Lsp settings
(load "~/.emacs.d/lisp/lsp")
;;; Autocomplete
(load "~/.emacs.d/lisp/company")
;;; Mac-os specific settings
(load "~/.emacs.d/lisp/mac")
;;; Lang settings
(load "~/.emacs.d/lisp/elixir")
(load "~/.emacs.d/lisp/rust")
(load "~/.emacs.d/lisp/nix")
(load "~/.emacs.d/lisp/csharp")
(load "~/.emacs.d/lisp/tree-sitter")
(load "~/.emacs.d/lisp/webmode")
;;; Terminals
(load "~/.emacs.d/lisp/term")
;;; Github Copilot
(load "~/.emacs.d/lisp/copilot")

;;; Send startup time as a message on startup.
(funs/display-startup-time)
