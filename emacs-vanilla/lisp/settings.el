;;; package -- Emacs settings
;; Check if we're on a mac
(defvar *is-mac* (eq system-type 'darwin))
;; Disable GUI elements
(setq inhibit-startup-message nil)
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
;; Making sure my faculty companions
;; don't kill me :-)
(setq-default c-basic-offset 4
              c-default-style "k&r")
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
(setq ring-bell-function 'ignore) 
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

;;; Better scrolling
(setq scroll-conservatively 101)
(when (display-graphic-p)
  (tab-bar-mode))

(setq compilation-scroll-output 'first-error)

(setq indicate-empty-lines t)

;;; For better readability
(setq line-spacing 4)

;;; Numbers for tab bar
(setq tab-bar-tab-hints t)
