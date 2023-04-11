;;; ../emacs-doom-config/private-elisp/utils.el -*- lexical-binding: t; -*-

;;; Utilites
(defun toggle-lines ()
  (interactive)
  (cond ((eq display-line-numbers 'relative)
         (setq display-line-numbers 't))
        ((eq display-line-numbers 't)
         (setq display-line-numbers 'relative))))

(defun replace-with-indices(to-replace)
  ;; Replace every occurrence of to-replace appending a number
  ;; to the end, starts counting from 0
  (interactive "MInput Regex: ")
  (let ((i 0))
    (while (search-forward-regexp to-replace nil t)
      (let ((replacement
             (concat to-replace
                     (number-to-string i))))
        (when (y-or-n-p "Replace?")
          (replace-match replacement)
          (setq i (1+ i)))))))
