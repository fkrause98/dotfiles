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
;;; For when I like to do some web programming
(setq httpd-root "~/Programación/")
(add-hook! 'web-mode 'my-impatient-mode-server-url)
(defun start-my-server ()
  (interactive)
  (progn
    (httpd-start)
    (impatient-mode 1)
    (my-impatient-mode-server-url)))
(defun my-impatient-mode-server-url()
  (interactive)
  (progn
  (kill-new "http://localhost:8080/imp/")))
;;; Believe it or not, emacs has a mode for telegram
(when (featurep 'telega)
  (telega-mode-line-mode 1)
  (add-hook 'telega-load-hook
            #'(lambda ()
                (define-key global-map (kbd "C-c t") telega-prefix-map))))

;;; Elixir
(setq elixir-ls-folder "/home/francisco/elixir-ls/release")
(setq highlight-indent-guides-method 'character)

;;; Scrolling animations when jumping around
(with-eval-after-load 'evil (scroll-on-jump-advice-add evil-undo)
                      (scroll-on-jump-advice-add evil-redo)
                      (scroll-on-jump-advice-add evil-jump-item)
                      (scroll-on-jump-advice-add evil-jump-forward)
                      (scroll-on-jump-advice-add evil-jump-backward)
                      (scroll-on-jump-advice-add evil-ex-search-next)
                      (scroll-on-jump-advice-add evil-ex-search-previous)
                      (scroll-on-jump-advice-add evil-forward-paragraph)
                      (scroll-on-jump-advice-add evil-backward-paragraph)
                      ;; Actions that themselves scroll.
                      (scroll-on-jump-with-scroll-advice-add evil-scroll-down)
                      (scroll-on-jump-with-scroll-advice-add evil-scroll-up)
                      (scroll-on-jump-with-scroll-advice-add evil-scroll-line-to-center)
                      (scroll-on-jump-with-scroll-advice-add evil-scroll-line-to-top)
                      (scroll-on-jump-with-scroll-advice-add evil-scroll-line-to-bottom))
(with-eval-after-load 'goto-chg (scroll-on-jump-advice-add goto-last-change)
                      (scroll-on-jump-advice-add goto-last-change-reverse))


(setq scroll-on-jump-use-curve t)

