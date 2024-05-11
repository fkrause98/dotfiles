;;; linux.el -*- lexical-binding: t; -*-
;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (when (display-graphic-p)
;;; Shell to use
(setq shell-file-name "/usr/share/bash"
      vterm-shell "fish")
(let ((fonts (font-family-list)))
  ;; (when (or (member "Fira Code" fonts)
  ;;           (member "FiraCode Nerd Font" fonts)
  ;;   (setq doom-font (font-spec :family "Fira Code Medium" :size 12)))
  (when (member "EB Garamond" fonts)
    (setq doom-variable-pitch-font (font-spec :family "EB Garamond" :size 12))))

