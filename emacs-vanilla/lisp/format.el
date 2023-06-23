(use-package format-all
  :hook prog-mode
  :after (general)
  :straight t
  :config
  (keys/leader
   "f" 'format-all-region-or-buffer)) 

