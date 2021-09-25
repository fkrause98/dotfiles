(defun funcs//derived-modes (mode)
  "Return a list of the ancestor modes that MODE is derived from."
  (let ((modes   ())
        (parent  nil))
    (while (setq parent (get mode 'derived-mode-parent))
      (push parent modes)
      (setq mode parent))
    (setq modes  (nreverse modes))))

(defun funcs//prettify-mode-hook ()
  "Apply prettify mode over list"
  (dolist (mode '(emacs-lisp-mode-hook))
    (add-hook mode (lambda () (prettiffy-symbols-hook))))) 

(defun funcs//new-buffer ()
  "Wait for input and create a new buffer"
  (interactive)
  (let ((new-buffer (read-string "New buffer name: ")))
    (if (string-empty-p new-buffer)
	(switch-to-buffer (concat "new-buff"(number-to-string (random 100))))
	(switch-to-buffer new-buffer))))
(defun funcs//tree-sitter-has-lang  (mode)
  (assoc mode tree-sitter-major-mode-language-alist))
  
			       
    
  
