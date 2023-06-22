;;; package  -- Csharp
(use-package csharp-mode
  :commands (csharp-mode)
  :straight t
  :mode "\\.cs\\'"
  :init
  (add-hook 'csharp-mode-hook 'csharp-tree-sitter-mode)
  :hook
  ((csharp-mode) . tree-sitter-hl-mode))
