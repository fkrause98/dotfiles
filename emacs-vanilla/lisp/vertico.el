;;; package -- Vertico related config
(use-package vertico
  :straight t
  :init
  (vertico-mode))
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
  :bind (("C-s" . consult-line)
         ("C-x b" . consult-buffer)
         ("C-x C-b" . consult-buffer)
         ("C-x C-f" . consult-find)))
(use-package consult-lsp
  :straight t
  :after (consult lsp-mode)
  :bind (:map lsp-mode-map
              ("C-c C-l" . consult-lsp-symbols)))
(use-package consult-projectile
  :straight t
  :after (:all (consult projectile)))
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
