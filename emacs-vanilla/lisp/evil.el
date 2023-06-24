;;; package -- For the evil you need in your life :-)
(use-package evil
  :straight t
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil
        evil-want-C-u-scroll t
        evil-undo-system 'undo-fu)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line))

(use-package evil-matchit
  :straight t
  :hook prog-mode
  :config
  (global-evil-matchit-mode 1))

(use-package evil-surround
  :commands (evil-surround-mode)
  :defines global-evil-surround-mode
  :straight t
  :config
  (global-evil-surround-mode 1)
  :init
  (add-hook 'evil-mode-hook 'evil-surround-mode))

(use-package evil-smartparens
  :straight t
  :requires smartparens
  :hook (smartparens-global-mode . evil-smart-parens)
  :after (:all (evil smartparens)))

(use-package evil-collection
  :straight t
  :hook prog-mode
  :config
  (evil-collection-init))
(use-package evil-surround
  :straight t
  :after evil-mode
  :commands (global-evil-surround-mode
             evil-surround-edit
             evil-Surround-edit
             evil-surround-region)
  :config (global-evil-surround-mode 1))

(defun funcs/enable-surround-mode nil
  (global-evil-surround-mode 1))
(add-hook 'after-init-hook #'funcs/enable-surround-mode)
(use-package evil-nerd-commenter
  :straight t
  :after evil-mode
  :config (evilnc-default-hotkeys))
;; (straight-use-package 'evil-nerd-commenter)

(use-package scroll-on-jump
  :straight t
  :config
  (with-eval-after-load 'evil
    (scroll-on-jump-advice-add evil-undo)
    (scroll-on-jump-advice-add evil-redo)
    (scroll-on-jump-advice-add evil-jump-item)
    (scroll-on-jump-advice-add evil-jump-forward)
    (scroll-on-jump-advice-add evil-jump-backward)
    (scroll-on-jump-advice-add evil-ex-search-next)
    (scroll-on-jump-advice-add evil-ex-search-previous)
    (scroll-on-jump-advice-add evil-forward-paragraph)
    (scroll-on-jump-advice-add evil-backward-paragraph)
    (scroll-on-jump-advice-add evil-goto-mark)

    ;; Actions that themselves scroll.
    (scroll-on-jump-with-scroll-advice-add evil-goto-line)
    (scroll-on-jump-with-scroll-advice-add evil-scroll-down)
    (scroll-on-jump-with-scroll-advice-add evil-scroll-up)
    (scroll-on-jump-with-scroll-advice-add evil-scroll-line-to-center)
    (scroll-on-jump-with-scroll-advice-add evil-scroll-line-to-top)
    (scroll-on-jump-with-scroll-advice-add evil-scroll-line-to-bottom))

  (with-eval-after-load 'goto-chg
    (scroll-on-jump-advice-add goto-last-change)
    (scroll-on-jump-advice-add goto-last-change-reverse))

  (global-set-key (kbd "<C-M-next>") (scroll-on-jump-interactive 'diff-hl-next-hunk))
  (global-set-key (kbd "<C-M-prior>") (scroll-on-jump-interactive 'diff-hl-previous-hunk)))
