(use-package yaml-mode
  :straight t
  :commands yaml-mode
  :hook (yaml-mode . tree-sitter-hl-mode)
  :mode (("\\.yml\\'" . yaml-mode)
         ("\\.yaml\\'" . yaml-mode)))
(use-package yaml-imenu
  :commands (yaml-imenu-enable)
  :hook (yaml-mode . yaml-imenu-enable))
