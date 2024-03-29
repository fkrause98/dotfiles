;;; package -- Vertico related config
(use-package vertico
  :straight t
  :config
  (setq vertico-resize nil ; Fixed size for vertico
        vertico-count 17 ; Number of lines to display
        vertico-cycle t)
  :init
  (vertico-mode)
  :bind (("C-j" . vertico-next)
         ("C-k" . vertico-previous)))
;; Configure directory extension.
(use-package vertico-directory
  :commands
  (vertico-directory-enter
   vertico-directory-delete-char
   vertico-directory-delete-word)
  :straight
  (:host github :repo "minad/vertico" :files ("extensions/vertico-directory.el"))
  :ensure nil
  ;; More convenient directory navigation commands
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word)
              ("C-u" . vertico-directory-delete-word))
  ;; Tidy shadowed file names
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

(use-package vertico-multiform
  :straight
  (:host github :repo "minad/vertico" :files ("extensions/vertico-multiform.el")))
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
  (setq x-ref-show-xrefs-function #'consult-xref
        xref-show-xrefs-function #'consult-xref)
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
  :after (:all (consult projectile))
  :config
  (setq consult-projectile-use-projectile-switch-project t))

(use-package consult-flycheck
  :defines (consult-flycheck)
  :commands (consult-flycheck)
  :straight t
  :after (:all (consult flycheck)))

(use-package consult-tramp
  :commands (consult-tramp)
  :straight (:host github
                   :repo "Ladicle/consult-tramp"))
(use-package docker-tramp
  :commands (
             docker-tramp-cleanup
             docker-tramp-add-method
             docker-tramp--running-containers
             docker-tramp--parse-running-containers))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides
   '((file (styles basic basic-remote partial-completion))))
  (orderless-matching-styles
   '(orderless-literal
     orderless-prefixes
     orderless-initialism
     orderless-regexp)))

(use-package marginalia
  :ensure t
  :config
  (marginalia-mode))

(use-package embark
  :straight t
  :after vertico
  :bind
  (
   ;; ("C-b" . embark-act)
   ("C-a" . embark-export)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init

  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  ;; Show the Embark target at point via Eldoc.  You may adjust the Eldoc
  ;; strategy, if you want to see the documentation from multiple providers.
  (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  ;; (setq eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)

  :config

  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil)))


;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :straight t ; only need to install it, embark loads it after consult if found
  :after (embark consult)
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))
;; (consult-customize consult--source-buffer :hidden t :default nil)
