;;; package -- Projectile related config.
(use-package projectile
  :diminish projectile-mode
  :hook after-init-hook
  :defines (projectile-mode
             projectile-find-file
             projectile-switch-project
             projectile-project-root
             projectile-completing-read)
  :straight t
  :config
  (setq projects-folder nil)
  (setq projectile-switch-project-action #'project/find-file
        projectile-sort-order 'recently-active
        projectile-enable-caching t
        projectile-generic-command "rg --files --hidden"
        projectile-indexing-method 'hybrid))

(use-package projectile-ripgrep
  :diminish projectile-ripgrep-mode
  :after projectile
  :straight t)


;;;###autoload
(defun search/project-text-search nil
  (interactive)
  (consult-ripgrep (projectile-project-root)))

;;;###autoload
(defun project/find-file nil
  (interactive)
  (projectile-find-file))

;;;###autoload
(defun project/get-project-root ()
  (interactive)
  (if (fboundp 'projectile-project-root)
      (projectile-project-root)
    (message "Project root function not defined -- Maybe projectile is missing?")))
