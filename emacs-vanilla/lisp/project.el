;;; package -- Projectile related config.
(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (let
      ((projects-folder (expand-file-name "~/Programming")))
    (when
	(file-directory-p projects-folder))
    (setq projectile-project-search-path '("~/Programming")))
  (setq projectile-switch-project-action #'projectile-find-file
        projectile-sort-order 'recently-active
        projectile-enable-caching t
        ))
(use-package counsel-projectile
  :config (counsel-projectile-mode))
(use-package projectile-ripgrep)
(setq projectile-generic-command "rg --files --hidden")
