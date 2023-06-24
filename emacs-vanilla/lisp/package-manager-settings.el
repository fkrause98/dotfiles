;;; package -- Use package settings
;; Boostrap straight
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq use-package-always-ensure nil)
(setq straight-use-package-by-default t)

(use-package benchmark-init
  :straight (:host github
                   :repo "dholm/benchmark-init-el"
                   :commit "02435560415bbadbcf5051fb7042880549170e7e")
  :config
  (add-hook 'after-init-hook 'benchmark-init/deactivate))

