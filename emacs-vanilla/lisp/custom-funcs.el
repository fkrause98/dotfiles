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
