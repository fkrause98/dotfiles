;;; package -- Git config.
(use-package magit
  :commands (masit-status magit-get-current-branch)
  :custom (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))
