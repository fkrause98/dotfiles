;;; package  -- Csharp
(use-package csharp-mode
  :commands (csharp-mode)
  :straight t
  :mode "\\.cs\\'"
  :init
  (add-hook 'csharp-mode-hook 'csharp-tree-sitter-mode)
  (add-hook 'csharp-tree-sitter-mode
            #'(lambda ()
                (tree-sitter-indent-mode -1)
                (setq-local lsp-auto-guess-root t)
                (lsp)))
  :hook
  ((csharp-mode) . tree-sitter-hl-mode))
