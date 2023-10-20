;;; package -- Custom functions
;;;###autoload
(defun funs/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                   (time-subtract after-init-time before-init-time)))
           gcs-done))

;;;###autoload
(defun funs/revert-buffer-no-confirm ()
  "Revert buffer without confirmation."
  (interactive)
  (revert-buffer t t))

;;;###autoload
(defun funs/hex-to-dec (hex-number)
  (interactive "sNumber in hex to convert: ")
  (require 's)
  (when (s-starts-with? "0x" hex-number)
     (setq hex-number (string-remove-prefix "0x" hex-number)))
  (message (format "%d" (string-to-number hex-number 16))))

;;;###autoload
(defun funs/remove-ansi-color ()
  (interactive)
  (save-excursion
   (mark-whole-buffer)
   (ansi-color-filter-region (region-beginning) (region-end))))

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
  (let ((file-name (files/get-current-file-name)))
    (message (format "Yanked file name: %s" file-name))
    (evil-set-register ?\" file-name)))

;;;###autoload
(defun search/project-text-search nil
  (interactive)
  (consult-ripgrep (projectile-project-root)))

;;;###autoload
(defun project/run-project ()
  (interactive)
  (if (bound-and-true-p projectile-mode)
      (call-interactively #'projectile-run-project)
    (message "Projectile mode is not running!")))

;;;###autoload
(defun project/find-file nil
  "Find file in project"
  (interactive)
  (consult-projectile-find-file))

;;;###autoload
(defun project/get-project-root ()
  (interactive)
  (if (fboundp 'projectile-project-root)
      (projectile-project-root)
    (message "Project root function not defined -- Maybe projectile is missing?")))

;;;###autoload
(defun project/switch-to-project ()
  (interactive)
  (call-interactively 'consult-projectile-switch-project))

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

;;;###autoload
(defun code/show-errors ()
  (interactive)
    (call-interactively #'consult-flycheck))

;;;###autoload
(defun code/find-definition ()
  (interactive)
  (if lsp-mode
      (call-interactively #'lsp-find-definition)
    (call-interactively #'xref-find-definitions)))

;;;###autoload
(defun code/find-references ()
  (interactive)
  (if lsp-mode
      (call-interactively #'lsp-find-references)
    (call-interactively #'xref-find-references)))

;;;###autoload
(defun evil/record-macro-or-kill-popper-buffer ()
  (interactive)
  (if (popper-popup-p (current-buffer))
      (call-interactively #'popper-kill-latest-popup)
    (call-interactively #'evil-record-macro)))


