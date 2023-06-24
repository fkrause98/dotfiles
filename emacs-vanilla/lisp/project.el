;;; package -- Projectile related config.
(use-package projectile
  :diminish projectile-mode
  :commands (
             projectile-mode
             projectile-find-file
             projectile-switch-project
             projectile-project-root
             )
  :straight t
  :init
  (let
      ((projects-folder (expand-file-name "~/Programming")))
    (when
        (file-directory-p projects-folder))
    (setq projectile-project-search-path
          nil
     ))
  (setq projectile-switch-project-action #'find-file
        projectile-sort-order 'recently-active
        projectile-enable-caching t
        projectile-generic-command "rg --files --hidden"
        ;; Avoid projectile using ivy
        projectile-completion-system nil
	projectile-indexing-method 'hybrid))
(add-hook 'after-init-hook 'projectile-mode)

(use-package projectile-ripgrep
  :diminish projectile-ripgrep-mode
  :after projectile
  :straight t)

(defun search/project-text-search nil
  (interactive)
  (consult-ripgrep (projectile-project-root)))

(defun project/find-file nil
  (interactive)
  (projectile-find-file))

(defun project/get-project-root ()
  (interactive)
  (if (fboundp 'projectile-project-root)
      (projectile-project-root)
    (message "Project root function not defined -- Maybe projectile is missing?")))
