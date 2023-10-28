;;; Tame emacs pop buffers!
(use-package popper
  :straight t 
  :bind (("C-`"   . popper-toggle-latest)
         ("M-`"   . popper-cycle)
         ("C-M-`" . popper-toggle-type))
  :init
  (setq popper-reference-buffers
                                        ; Make some buffers toggable
        '("\\*Messages\\*"
          "\\*Shell Command Output\\*"
          "Output\\*$"
          "\\*Async Shell Command\\*"
          "\\*Command Line\\*"
          "\\*Warnings\\*"
          "\\*rustic-compilation\\*"
          "\\*exunit-compilation\\*"
          "\\*nix-fmt\\*"
          "\\*cargo-test\\*"
          help-mode
          compilation-mode
          rustic-compilation-mode
          rustic-cargo-test-mode
          occur-mode
          grep-mode
          helpful-mode))
  (setq popper-window-height 20)
  (popper-mode +1)
  (popper-echo-mode +1)
  (with-eval-after-load "keys"
    (general-define-key
     :states 'normal                                 
     "q" 'evil/record-macro-or-kill-popper-buffer)))

;;;###autoload
(defun funs/set-theme ()
  (load-theme 'doom-tokyo-night))

(use-package doom-themes
  :hook (after-init . funs/set-theme))

(use-package color-theme-sanityinc-tomorrow)

;; (use-package doom-modeline
;;   :straight t
;;   :config
;;   (setq doom-modeline-icon nil)
;;   (setq doom-themes-enable-bold nil)
;;   (doom-modeline-mode 1))


;; Center text when only 1 window
;; is open
(use-package perfect-margin
  :straight t
  :hook (after-init . perfect-margin-mode)
  :config
  (perfect-margin-mode 1))

;; A nice startup dashboard
(use-package dashboard
  :straight t
  :init
  (setq dashboard-startup-banner 'logo
        dashboard-center-content t
        dashboard-items '((projects . 10)
                          (recents . 10)))
  (add-hook 'dashboard-after-initialize-hook 'dashboard-jump-to-projects)
  (dashboard-setup-startup-hook))

(use-package modus-themes)

(use-package standard-themes)

;;; Darker contrast, works
;;; well with doom-themes.
(use-package solaire-mode
  :if (display-graphic-p)
  :hook (after-init . solaire-global-mode))

(use-package all-the-icons
  :if (display-graphic-p))

(use-package all-the-icons-completion
  :hook (after-init . all-the-icons-completion-mode)
  :if (display-graphic-p)
  :straight (:host github
                   :repo "iyefrat/all-the-icons-completion"
                   :commit "8eb3e410d63f5d0657b41829e7898793e81f31c0"))

(use-package all-the-icons-dired
  :after (all-the-icons)
  :if (display-graphic-p)
  :hook (dired-mode . all-the-icons-dired-mode))

;; Set font for mac
(let ((font-to-use  "FiraCode Nerd Font Mono"))
  (if *is-mac*
      (set-face-attribute 'default nil :family font-to-use)
    (message (format "Missing font: %s" font-to-use))))

(use-package mini-echo
  :commands (mini-echo-mode)
  :hook (after-init . mini-echo-mode)
  :straight (:host github
                   :repo "liuyinz/mini-echo.el"
                   :commit "a8b30a91986be60e718963e2c78cae3c3a3c3b76")
  :config
;; set default segments of long/short style
(setq mini-echo-default-segments
  '(:long ("major-mode" "buffer-name" "vcs" "buffer-position"
           "buffer-size" "flymake" "process" "selection-info"
           "narrow" "macro" "profiler")
    :short ("buffer-name-short" "buffer-position" "process"
            "profiler" "selection-info" "narrow" "macro"))))
