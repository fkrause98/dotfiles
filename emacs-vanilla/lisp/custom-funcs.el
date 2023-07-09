;;; package -- Custom functions
;;;###autoload
(defun funs/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                   (time-subtract after-init-time before-init-time)))
           gcs-done))

;;;###autoload
(defun funcs/revert-buffer-no-confirm ()
  "Revert buffer without confirmation."
  (interactive)
  (revert-buffer t t))

;;;###autoload
(defun files/delete-this-file ()
  "Delete the file corresponding to the current buffer, if any"
  (interactive)
  (when (yes-or-no-p "Are you sure you want to delete this file?")
    (delete-file
     (expand-file-name (buffer-name)))))

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
  "Copy the current file's name"
  (interactive)
  (evil-set-register ?\" (files/get-current-file-name)))

;;;###autoload
(defun search/project-text-search nil
  (interactive)
  (consult-ripgrep (projectile-project-root)))

;;;###autoload
(defun project/find-file nil
  "Find file in project"
  (interactive)
  (projectile-find-file))

;;;###autoload
(defun project/get-project-root ()
  (interactive)
  (if (fboundp 'projectile-project-root)
      (projectile-project-root)
    (message "Project root function not defined -- Maybe projectile is missing?")))

;;;###autoload
(defun search/search-current-buffer ()
  (interactive)
  (consult-line))
;;;###autoload
(defun buffers/switch-project-buffer ()
  (interactive)
  (consult-project-buffer))
;;;###autoload
(defun buffers/switch-buffer ()
  (interactive)
  (consult-buffer))
;;;###autoload
(defun files/recent ()
  (interactive)
  (consult-recent-file))
