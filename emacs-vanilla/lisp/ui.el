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
          ;; "^\\*vterm.*\\*$"
          "\\*rustic-compilation\\*"
          "\\*exunit-compilation\\*"
          help-mode
          compilation-mode
          rustic-compilation-mode))
  (setq popper-window-height 20)
  (popper-mode +1)
  (popper-echo-mode +1)
  (with-eval-after-load "keys"
    (general-define-key
     :states 'normal                                 
     "q" 'evil/record-macro-or-kill-popper-buffer)))

;; Nice themes 
(use-package doom-themes
  :straight t)

;; Center text when only 1 window
;; is open
(use-package perfect-margin
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

