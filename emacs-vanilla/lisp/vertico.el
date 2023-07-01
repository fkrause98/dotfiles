;;; package -- Vertico related config
(use-package vertico
  :straight t
  :config (setq vertico-count 17)
  :init
  (vertico-mode)
  :bind (("C-j" . vertico-next)
         ("C-k" . vertico-previous)
         ("DEL" . vertico-directory-del)))
;; Configure directory extension.
(use-package vertico-directory
  :after vertico
  :straight
  (:host github :repo "minad/vertico" :files ("extensions/vertico-directory.el"))
  :ensure nil
  ;; More convenient directory navigation commands
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word))
  ;; Tidy shadowed file names
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

(use-package marginalia
  :after vertico
  :ensure t
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))
(use-package consult
  :defines
  (consult-line
   consult-buffer
   consult-find
   consult-find-project
   consult-ripgrep
   consult-recent-file)
  :straight t
  :config
  :bind (("C-s" . consult-line)
         ("C-x b" . consult-buffer)
         ("C-x C-b" . consult-buffer)
         ("C-x C-f" . consult-find)))
(use-package consult-lsp
  :straight t
  :after (consult lsp-mode)
  :bind (:map lsp-mode-map
              ("C-c C-l" . consult-lsp-symbols)))
(setq vertico-count 15)
(use-package consult-projectile
  :straight t
  :after (:all (consult projectile)))
(use-package consult-flycheck
  :defines (consult-flycheck)
  :commands (consult-flycheck)
  :straight t
  :after (:all (consult flycheck)))
(defun search/search-current-buffer ()
  (interactive)
  (consult-line))
(defun buffers/switch-project-buffer ()
  (interactive)
  (consult-project-buffer))
(defun buffers/switch-buffer ()
  (interactive)
  (consult-buffer))
(defun files/recent ()
  (interactive)
  (consult-recent-file))
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))
