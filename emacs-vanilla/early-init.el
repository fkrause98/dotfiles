;; disable package.el to use straight instead
(setq package-enable-at-startup nil)
;;; Move this awful file somewhere else
(setq custom-file
      (concat user-emacs-directory "~/.emacs/.custom.el"))
;;; Move backup files to another folder,
;;; instead of creating them everywhere
(setq backup-directory-alist `(("." . "~/.saves")))
