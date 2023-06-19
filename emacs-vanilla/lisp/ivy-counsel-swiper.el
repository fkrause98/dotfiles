;;; package -- Ivy-counsel-swiper
;; Ivy, counsel and swiper are closely related,
;; so let's have them in a single config file :-).
(use-package swiper :straight t)
(use-package counsel
  :after ivy
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history)))
(use-package ivy
  :diminish ivy-mode 
  :straight t
  :bind (:map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)	
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :init
  ;; No initial input
  (setq ivy-initial-inputs-alist nil)
  ;; Make ivy bigger, default
  ;; is 10
  (setq ivy-height-alist 
        '((counsel-evil-registers . 15)
         (counsel-yank-pop . 15)
         (counsel-git-log . 15)
         (counsel-ibuffer . 15)
         ))
  (setq ivy-height 15)
  ;; Orderless matching
  (setq ivy-re-builders-alist
        '((ivy-switch-buffer . ivy--regex-plus)
          (t . ivy--regex-ignore-order)))
  ;; Make the input selectable, to
  ;; be able to perform an action
  ;; when there is a single, perfect match
  ;; that has the same name as the input.
  (setq ivy-use-selectable-prompt t)
  :config
  (ivy-mode 1))
;; (use-package ivy-rich
  ;; :after ivy
  ;; :config
  ;; (ivy-rich-mode 1))
