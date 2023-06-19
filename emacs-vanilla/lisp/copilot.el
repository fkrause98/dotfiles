(use-package copilot
  :commands copilot-mode
  :straight (:host github :repo "zerolfx/copilot.el" :files ("dist" "*.el"))
  :bind
  (("TAB" . copilot-accept-completion))
  :init
  (add-hook 'prog-mode-hook #'copilot-mode))
