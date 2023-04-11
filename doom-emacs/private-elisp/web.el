;;; ../emacs-doom-config/private-elisp/web.el -*- lexical-binding: t; -*-

;;; Web mode
;; Useful for higlighting tags.
(setq web-mode-enable-current-element-highlight t)
(add-hook 'web-mode-hook
          (lambda ()
            ;; Indent to 2 spaces.
            (setq web-mode-markup-indent-offset 2)
            (setq web-mode-css-indent-offset 2)
            (setq web-mode-code-indent-offset 2)
            (setq web-mode-enable-current-column-highlight t)
            (setq evil-shift-width 2)))
