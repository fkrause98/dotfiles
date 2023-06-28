;;; package -- Git config.
(use-package magit
  :straight t
  :commands (magit-status magit-get-current-branch)
  :custom (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
  :config
  (setq magit-save-repository-buffers 'dontask))
