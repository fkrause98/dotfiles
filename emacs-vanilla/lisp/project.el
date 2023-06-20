;;; package -- Projectile related config.
(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :straight t
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (let
      ((projects-folder (expand-file-name "~/Programming")))
    (when
	(file-directory-p projects-folder))
    (setq projectile-project-search-path '("~/Programming" . 2)))
  (setq projectile-switch-project-action #'projectile-find-file
        projectile-sort-order 'recently-active
        projectile-enable-caching t
        projectile-generic-command "rg --files --hidden"
        projectile-completion-system 'ivy))

(use-package counsel-projectile
  :diminish counsel-projectile-mode
  :commands (counsel-projectile-find-file-dwim)
  :straight t
  :config (counsel-projectile-mode))
(use-package projectile-ripgrep
  :diminish projectile-ripgrep-mode
  :after projectile
  :straight t)
