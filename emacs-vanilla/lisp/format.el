(use-package format-all
  :hook prog-mode
  :straight t
  :config
  (keys/leader-def
    "f" 'format-all-buffer)) 

