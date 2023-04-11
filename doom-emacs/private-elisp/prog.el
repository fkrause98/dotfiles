;;; ../../emacs-doom-config/private-elisp/prog.el -*- lexical-binding: t; -*-

;;; General programming options

(dolist (hook '(c-mode-hook solidity-mode-hook rust-mode-hook))
  (add-hook hook 'tree-sitter-hl-mode))
(dolist (hook '(c-mode-hook solidity-mode-hook ))
  (add-hook hook 'smart-semicolon-mode))
