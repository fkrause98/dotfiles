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
  (setq projectile-switch-project-action 'find-file
        projectile-sort-order 'recently-active
        projectile-enable-caching t
        projectile-generic-command "rg --files --hidden"
        projectile-indexing-method 'hybrid))

(use-package projectile-ripgrep
  :diminish projectile-ripgrep-mode
  :after projectile
  :straight t)


