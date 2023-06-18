;;; package -- Ivy-counsel-swiper
;; Ivy, counsel and swiper are closely related,
;; so let's have them in a single config file :-).
(use-package swiper :ensure t)
(use-package counsel
  :after ivy
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history)))
(use-package ivy
  :diminish ivy-mode 
  :ensure t
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
  :config
  (ivy-mode 1)
  ;; Ignore initial inputs in ivy
  (setq ivy-initial-inputs-alist nil)
  ;; Orderless matching
  (setq ivy-re-builders-alist
        '((ivy-switch-buffer . ivy--regex-plus)
          (t . ivy--regex-ignore-order))))
(use-package ivy-rich
  :after ivy
  :init
  (ivy-rich-mode 1))
