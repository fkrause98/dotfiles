;;; ../../emacs-doom-config/private-elisp/ui.el -*- lexical-binding: t; -*-
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

(when (eq system-type 'gnu/linux)
  (setq doom-theme 'doom-gruvbox))
(when (eq system-type 'darwin)
  (setq doom-theme 'doom-palenight))
(setq doom-themes-enable-bold t
      doom-themes-enable-italic t)
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
;; (setq display-line-numbers-type 'relative)
(setq display-line-numbers-type 'relative)

;;; Ui related config
;; Dashboard image
(when (or (display-graphic-p)
           (daemonp))
   (random-banner-image (concat doom-config-dir "/splash" )))
(add-hook
 'dashboard-mode-hook
 #'(lambda ()
     (perfect-margin-mode -1)))

;; Helps to see better, a little at least.
(when (display-graphic-p)
  (setq-default line-spacing 4))
(setq highlight-indent-guides-responsive 'top)

;; Scrolling
(setq scroll-conservatively 101)

;;; Treemacs
(setq doom-themes-treemacs-variable-pitch-face nil)


;;; Indent chars
(setq highlight-indent-guides-method 'character)
