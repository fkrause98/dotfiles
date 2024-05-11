;;; ../emacs-doom-config/private-elisp/eshell.el -*- lexical-binding: t; -*-

;;; Eshell
(after! eshell
  (eshell-vterm-mode)
  (defalias 'eshell/v 'eshell-vterm-exec-visual)
  (setq eshell-up-ignore-case nil)
  (setq eshell-term-name "xterm-256color"))
