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

(use-package doom-themes)

(use-package color-theme-sanityinc-tomorrow)

(use-package doom-modeline
  :straight t
  :config
  (setq doom-modeline-icon nil)
  (doom-modeline-mode 1))

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

;; Set font for mac
(when *is-mac*
  (set-face-attribute 'default nil :family "JetBrains Mono"))

;;;###autoload
(defun custom-ui-after-init-hook ()
  (load-theme 'modus-vivendi)
  (tab-bar-mode))

(add-hook 'after-init-hook '(lambda () (load-theme 'doom-tokyo-night)))
