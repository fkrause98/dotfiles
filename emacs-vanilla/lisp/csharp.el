;;; package  -- Csharp
(use-package csharp-mode
  :straight t
  :mode ("\\.cs\\'" . chsarp-mode)
  :config
  (add-to-list 'auto-mode-alist '("\\.cs\\'" . csharp-tree-sitter-mode)))
