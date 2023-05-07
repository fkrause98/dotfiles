;;; ../../emacs-doom-config/private-elisp/prog.el -*- lexical-binding: t; -*-

;;; General programming options

(dolist (hook '(c-mode-hook solidity-mode-hook rust-mode-hook))
  (add-hook hook 'tree-sitter-hl-mode))
(dolist (hook '(c-mode-hook solidity-mode-hook))
  (add-hook hook 'smart-semicolon-mode))
(defun perfect-margin-mode-setup nil
  (unless (eq major-mode 'web-mode)
    (perfect-margin-mode)))
;; Center text and add rainbow parens in programming-modes
(dolist (hook '(perfect-margin-mode-setup rainbow-delimiters-mode))
              (add-hook 'prog-mode-hook hook))

;; Formatting enabled modes
(setq +format-on-save-enabled-modes '(not emacs-lisp-mode ; elisp's mechanisms are good enough
                                          sql-mode ; sqlformat is currently broken
                                          tex-mode ; latexindent is broken
                                          latex-mode
                                          c++-mode ; C++ autoindent really sucks
                                          html-mode
                                          web-mode))
