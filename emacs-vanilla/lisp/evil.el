;;; package -- For the evil you need in your life :-)
(use-package evil
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

(use-package evil-surround
  :straight t
  :config (global-evil-surround-mode 1)
  :after (evil))
(use-package evil-smartparens
  :requires smartparens
  :hook (smartparens-global-mode . evil-smart-parens))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))
(use-package evil-nerd-commenter
  :init (evilnc-default-hotkeys))

(use-package scroll-on-jump
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
