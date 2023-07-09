;;; package -- Projectile related config.
(use-package projectile
  :diminish projectile-mode
  :hook (after-init . projectile-mode)
  :defines (projectile-mode
             projectile-find-file
             projectile-switch-project
             projectile-project-root
             projectile-completing-read)
  :straight t
  :config
  (setq projects-folder nil)
  (setq projectile-switch-project-action 'project/find-file
        projectile-sort-order 'recently-active
        projectile-enable-caching t
        projectile-generic-command "rg --files --hidden"
        projectile-indexing-method 'hybrid))

(use-package projectile-ripgrep
  :diminish projectile-ripgrep-mode
  :after projectile
  :straight t)

;;; Project keys
(with-eval-after-load "keys"
  (keys/leader
    "p" '(:ignore t :which-key "Project")
    "pa" '(projectile-add-known-project :which-key "Add project folder")
    "pf" '(consult-projectile-find-file :which-key "Find file")
    "pi" '(projectile-invalidate-cache :which-key "Add project folder")
    "pp" '(consult-projectile-switch-project :which-key "Switch")
    "pr" '(projectile-recentf  :which-key "Switch")
    "ps" '(search/project-text-search :which-key "Search text")))
