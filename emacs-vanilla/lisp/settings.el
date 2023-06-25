;;; package -- Emacs settings
;; Disable GUI elements
(setq inhibit-startup-message nil)
(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)
;; Disable the annoying visible bell
(setq visible-bell nil)
;; Line numbers
(column-number-mode)
;; Relative line numbers
(global-display-line-numbers-mode 'relative)
(setq display-line-numbers-type 'relative)
;; Disable line numbers in terminal modes
(dolist (mode '(term-mode-hook
		eshell-mode-hook
                vterm-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))
;; Space > Tabs
(setq-default indent-tabs-mode nil)
;; List recent files
(recentf-mode 1)
;; Remember last place on file
(save-place-mode 1)
;; Answer y/n instead of yes/no
(defalias 'yes-or-no-p 'y-or-n-p)
;; Disable emacs prompt
(setq use-dialog-box nil)
;; Do not ask for confirmation when
;; loading themes
(setq custom-safe-themes t)
(use-package ef-themes
  :after (consult-load-theme)
  :straight t)
(use-package doom-themes
  :config (if (eq system-type 'gnu/linux)
                               (load-theme 'doom-gruvbox)
                               (load-theme 'doom-palenight))
  :straight t)
(setq ring-bell-function 'ignore) 

;; Center text when only 1 window
;; is open
(use-package perfect-margin
  :hook (after-init . perfect-margin-mode)
  :config
  (perfect-margin-mode 1))
;;; Move this awful file somewhere else
(setq custom-file
      (concat user-emacs-directory "~/.emacs/.custom.el"))
;;; Move backup files to another folder,
;;; instead of creating them everywhere
(setq backup-directory-alist `(("." . "~/.saves")))
;;; Making sure people working with me don't kill me
(setq-default tab-width 2)
(setq-default evil-shift-width tab-width)
(setq truncate-lines t)
(setq-default truncate-lines t)
;;; Disable annoying compile warnings
(setq byte-compile-warnings nil)
(setq warning-minimum-level :error)
