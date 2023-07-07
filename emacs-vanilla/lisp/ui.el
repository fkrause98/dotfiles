(use-package doom-themes
  :straight t)
;; Center text when only 1 window
;; is open
(use-package perfect-margin
  :hook (after-init . perfect-margin-mode)
  :config
  (perfect-margin-mode 1))
