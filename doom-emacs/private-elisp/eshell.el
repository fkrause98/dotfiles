;;; ../emacs-doom-config/private-elisp/eshell.el -*- lexical-binding: t; -*-

;;; Eshell
(after! eshell
  (eshell-vterm-mode)
  (defalias 'eshell/v 'eshell-vterm-exec-visual)
  (setq eshell-up-ignore-case nil)
  (setq eshell-term-name "xterm-256color")
  ;; Redefine the eshell prompt function
  ;; to add a new line before the PS1.
  (defun +eshell-default-prompt-fn ()
    "Generate the prompt string for eshell. Use for `eshell-prompt-function'."
    (require 'shrink-path)
    (concat (if (bobp) "" "\n")
            (let ((pwd (eshell/pwd)))
              (propertize (if (equal pwd "~")
                              pwd
                            (abbreviate-file-name (shrink-path-file pwd)))
                          'face '+eshell-prompt-pwd))
            (propertize (+eshell--current-git-branch)
                        'face '+eshell-prompt-git-branch)
            (propertize "\n λ" 'face (if (zerop eshell-last-command-status) 'success 'error))
            " ")))
