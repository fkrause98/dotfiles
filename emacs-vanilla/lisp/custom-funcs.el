;;; package -- Custom functions
;;;###autoload
(defun funs/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                   (time-subtract after-init-time before-init-time)))
           gcs-done))
;; (add-hook 'emacs-startup-hook #'funs/display-startup-time)
;;;###autoload
(defun funcs/revert-buffer-no-confirm ()
  "Revert buffer without confirmation."
  (interactive)
  (revert-buffer t t))
;;;###autoload
(defun files/delete-this-file ()
  "Delete the file corresponding to the current buffer, if any"
  (interactive)
  (delete-file (expand-file-name (buffer-name))))

;;;###autoload
(defun files/sudo-this-file ()
  "Open the current file as super user"
  (interactive)
  (sudo-edit))

;;;###autoload
(defun files/get-current-file-name ()
  (interactive)
  (buffer-file-name nil))

;;;###autoload
(defun evil/yank-file-name ()
  (interactive)
  (evil-set-register ?\" (files/get-current-file-name)))

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
;;;###autoload
