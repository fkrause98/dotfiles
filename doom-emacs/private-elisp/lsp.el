;;; ../emacs-doom-config/private-elisp/lsp.el -*- lexical-binding: t; -*-


;;; LSP
(after! lsp-ui
  (setq lsp-ui-doc-enable nil))
(after! lsp
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-tramp-connection "clangd")
                    :major-modes '(c-mode)
                    :remote? t
                    :server-id 'clangd-remote))
  (setq lsp-headerline-breadcrumb-enable t))
