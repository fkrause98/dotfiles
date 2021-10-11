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
(defun funcs//toggle-lines ()
  (interactive)
  (if (eq display-line-numbers 'relative)
      (setq display-line-numbers t)
    (setq display-line-numbers 'relative)))

(defun funcs//load-scroll-on-jump-config ()
  (with-eval-after-load 'evil
    (scroll-on-jump-advice-add evil-undo)
    (scroll-on-jump-advice-add evil-redo)
    (scroll-on-jump-advice-add evil-jump-item)
    (scroll-on-jump-advice-add evil-jump-forward)
    (scroll-on-jump-advice-add evil-jump-backward)
    (scroll-on-jump-advice-add evil-ex-search-next)
    (scroll-on-jump-advice-add evil-ex-search-previous)
    (scroll-on-jump-advice-add evil-forward-paragraph)
    (scroll-on-jump-advice-add evil-backward-paragraph)
    (scroll-on-jump-advice-add evil-goto-mark)

    ;; Actions that themselves scroll.
    (scroll-on-jump-with-scroll-advice-add evil-goto-line)
    (scroll-on-jump-with-scroll-advice-add evil-scroll-down)
    (scroll-on-jump-with-scroll-advice-add evil-scroll-up)
    (scroll-on-jump-with-scroll-advice-add evil-scroll-line-to-center)
    (scroll-on-jump-with-scroll-advice-add evil-scroll-line-to-top)
    (scroll-on-jump-with-scroll-advice-add evil-scroll-line-to-bottom))

  (with-eval-after-load 'goto-chg
    (scroll-on-jump-advice-add goto-last-change)
    (scroll-on-jump-advice-add goto-last-change-reverse))

  (global-set-key (kbd "<C-M-next>") (scroll-on-jump-interactive 'diff-hl-next-hunk))
  (global-set-key (kbd "<C-M-prior>") (scroll-on-jump-interactive 'diff-hl-previous-hunk)))
