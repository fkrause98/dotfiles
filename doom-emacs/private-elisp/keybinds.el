;;; ../emacs-doom-config/private-elisp/keybinds.el -*- lexical-binding: t; -*-


;;; Random Keybindings
(map! :g "C-c C-b" 'eval-buffer)
(map! :g "C-x C-j" 'dired)
(map! :g "C-c f" 'counsel-recentf)
(map! :g "C-x C-b" '+ivy/switch-workspace-buffer)
;; Use C-{k,j} to move in ielm
(map! :map inferior-emacs-lisp-mode-map
      :i "C-k" 'comint-previous-input
      :i "C-j" 'comint-next-input
      :n "C-k" 'comint-previous-input
      :n "C-j" 'comint-next-input)

;; Scroll
(global-set-key (kbd "<mouse-4>") 'scroll-down-line)
(global-set-key (kbd "<mouse-5>") 'scroll-up-line)
