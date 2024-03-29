;;; package -- For the evil you need in your life :-)
(use-package evil
  :straight (:host github
                   :repo "emacs-evil/evil"
                   :commit "c4f95fd9ec284a8284405f84102bfdb74f0ee22f")
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil
        evil-want-C-u-scroll t
        evil-undo-system 'undo-tree
        evil-want-C-i-jump t
        evil-want-C-u-delete t
        evil-kill-on-visual-paste nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)
  (global-undo-tree-mode)
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line))

(use-package evil-visualstar
  :after evil
  :config (global-evil-visualstar-mode))

(use-package evil-matchit
  :straight t
  :defines global-evil-surround-mode
  :hook (after-init . global-evil-matchit-mode))

(use-package evil-snipe
  :straight t
  :defines (evil-snipe-mode evil-snipe-override-mode)
  :commands (evil-snipe-mode evil-snipe-override-mode)
  :hook (after-init . evil-snipe-override-mode)
  :config
  (setq evil-snipe-smart-case t))

(use-package evil-surround
  :commands global-evil-surround-mode
  :defines global-evil-surround-mode
  :straight t
  :hook (after-init . global-evil-surround-mode))

(use-package evil-nerd-commenter
  :straight t
  :after evil-mode
  :config (evilnc-default-hotkeys))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init)
  (evil-collection-consult-setup))
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
