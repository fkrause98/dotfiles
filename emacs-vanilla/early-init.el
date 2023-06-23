;; disable package.el to use straight instead
(setq package-enable-at-startup nil)
(setq inhibit-startup-message t)
(setq load-path (cons (expand-file-name "~/.emacs.d/lisp/")
                      load-path))
