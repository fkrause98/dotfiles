;;; package -- Projectile related config.
(use-package projectile
  :diminish projectile-mode
  :commands (projectile-mode projectile-find-file projectile-switch-project)
  :straight t
  :init
  (let
      ((projects-folder (expand-file-name "~/Programming")))
    (when
        (file-directory-p projects-folder))
    (setq projectile-project-search-path
          '(
            "~/Programming" . 2
            "~/dotfiles" . 2
            )
          ))
  (setq projectile-switch-project-action #'find-file
        projectile-sort-order 'recently-active
        projectile-enable-caching t
        projectile-generic-command "rg --files --hidden"
        projectile-completion-system 'auto
        projectile-indexing-method 'hybrid))
(add-hook 'after-init-hook 'projectile-mode)

(use-package projectile-ripgrep
  :diminish projectile-ripgrep-mode
  :after projectile
  :straight t)

(defun search/project-text-search nil
  (interactive)
  (consult-ripgrep))
