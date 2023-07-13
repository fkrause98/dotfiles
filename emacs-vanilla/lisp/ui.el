(use-package doom-themes
  :straight t)
;; Center text when only 1 window
;; is open

(use-package perfect-margin
  :hook (after-init . perfect-margin-mode)
  :config
  (perfect-margin-mode 1))

(use-package dashboard
  :straight t
  :init
  (setq dashboard-startup-banner 'logo
        dashboard-center-content t
        dashboard-items '((projects . 10)
                          (recents . 10)))
  (add-hook 'dashboard-after-initialize-hook 'dashboard-jump-to-projects)
  (dashboard-setup-startup-hook))
