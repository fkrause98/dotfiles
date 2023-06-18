;;; summary -- flycheck settings and download

(use-package flycheck
  :config
  (global-flycheck-mode))
(use-package flycheck
  :config
  (global-flycheck-mode))

(defun counsel-flycheck ()
  "Navigate to flycheck errors"
  (interactive)
  (if (not (bound-and-true-p flycheck-mode))
      (message "Flycheck mode is not available or enabled")
    (ivy-read "Error: "
	      (let ((source-buffer (current-buffer)))
		(with-current-buffer
		    (or (get-buffer flycheck-error-list-buffer)
			(progn
			  (with-current-buffer
			      (get-buffer-create flycheck-error-list-buffer)
			    (flycheck-error-list-mode)
			    (current-buffer))))
		  (flycheck-error-list-set-source source-buffer)
		  (flycheck-error-list-reset-filter)
		  (revert-buffer t t t)
		  (split-string (buffer-string) "\n" t " *")))
	      :action
	      (lambda (s &rest _)
		(when-let*
		    ((the-error (get-text-property 0 'tabulated-list-id s))
		     (pos (flycheck-error-pos the-error)) )
		  (goto-char (flycheck-error-pos the-error))))
	      :history 'counsel-flycheck-history)))



