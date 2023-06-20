(use-package copilot
  :defines (copilot copilot-mode)
  :straight (:host github :repo "zerolfx/copilot.el" :files ("dist" "*.el"))
  :bind
  (("C-c TAB" . copilot-accept-completion))
  :init
  (add-hook 'prog-mode-hook #'global-copilot-mode))
