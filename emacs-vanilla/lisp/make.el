(use-package makefile-executor
  :hook (makefile-mode . makefile-executor-mode))
;;;###autoload
(defun funcs/make-file-hook ()
  (setq-local indent-tabs-mode t))
(add-hook 'make-file-mode-hook 'funcs/make-file-hook)
