;;; ../emacs-doom-config/private-elisp/rust.el -*- lexical-binding: t; -*-

(setq rustic-format-on-save nil)
(add-hook 'rustic-mode-hook
          (lambda ()
            (setq lsp-signature-render-documentation nil
                  lsp-lens-enable nil)
            (when (boundp 'eglot-inlay-hints-mode)
              (eglot-inlay-hints-mode))))
