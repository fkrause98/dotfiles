;;; package -- Git config.
(use-package magit
  :straight t
  :commands (magit-status magit-get-current-branch)
  :custom (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
  :config
  (setq magit-save-repository-buffers 'dontask))
(use-package forge
  :after magit)
(use-package blamer
  :straight t
  :commands (blamer-mode global-blamer-mode)
  :defer 20
  :custom
  (blamer-idle-time 0.3)
  (blamer-min-offset 70)
  :custom-face
  (blamer-face ((t :foreground "#7a88cf"
                    :background nil
                    :height 140
                    :italic t))))
