;;; package --- Summary: Tree sitter
(use-package tree-sitter
  :straight t
  :commands tree-sitter-mode
  :hook
  ((rustic-mode) . tree-sitter-hl-mode))
(use-package tree-sitter-langs
  :straight t
  :after tree-sitter)
