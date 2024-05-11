;;; ../emacs-doom-config/private-elisp/ruby.el -*- lexical-binding: t; -*-
;;; Ruby
(add-hook 'ruby-mode (progn
                       (evil-define-key
                         '(normal insert) ruby-mode-map (kbd "C-c C-c")
                              'ruby-send-buffer)))
