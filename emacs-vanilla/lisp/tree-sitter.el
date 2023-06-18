;;; package --- Summary: Tree sitter
(use-package tree-sitter
  :ensure t
  :commands tree-sitter-mode
  :hook
  ((rustic-mode) . tree-sitter-hl-mode))
(use-package tree-sitter-langs
  :ensure t
  :after tree-sitter)
