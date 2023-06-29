;;; package  -- Csharp
(use-package csharp-mode
  :commands (csharp-mode)
  :straight t
  :mode "\\.cs\\'"
  :init
  (add-hook 'csharp-mode-hook 'cshar/mode-hook)
  :hook
  ((csharp-mode) . tree-sitter-hl-mode))

;;;###autoload
(defun csharp/mode-hook ()
  (csharp-tree-sitter-mode)
  (tree-sitter-indent-mode -1)
  (setq-local lsp-auto-guess-root t)
  (lsp))
