;;; ../emacs-doom-config/private-elisp/eshell.el -*- lexical-binding: t; -*-

;;; Eshell
(eshell-vterm-mode)
(defalias 'eshell/v 'eshell-vterm-exec-visual)
(setq eshell-up-ignore-case nil)
(add-hook 'eshell-mode-hook
          #'(lambda ()
              (company-mode -1)
              (esh-autosuggest-mode)))
(setq eshell-term-name "xterm-256color")
