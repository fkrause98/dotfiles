;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(setq user-full-name "Francisco Krause Arnim" user-mail-address "fkrause@gmail.com")

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;; OS
;; Config for Linux distros.
(when (eq system-type 'gnu/linux)
    (load! "linux"))
;; Config for MacOs.
(when (eq system-type 'darwin)
    (load! "mac"))
;;; Load files inside the "private-elisp" folder.
(setq doom-config-dir (expand-file-name "~/dotfiles/doom-emacs"))
(let ((no-dots-regex "^[^\.].*$")
      (private-elisp-fldr (concat doom-config-dir "/private-elisp")))
  (dolist
      (file (directory-files private-elisp-fldr t no-dots-regex))
        (load!  file)))
