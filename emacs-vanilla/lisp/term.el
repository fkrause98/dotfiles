;;; package -- Terminal settings
(use-package vterm
  :straight t
  :commands vterm
  :config
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")
  (setq vterm-shell "fish")
  (setq vterm-max-scrollback 10000))

(use-package vterm-toggle
  :straight t
  :commands vterm-toggle
  :requires vterm)

(use-package eat
  :straight t
  :commands (eat eat-mode))
