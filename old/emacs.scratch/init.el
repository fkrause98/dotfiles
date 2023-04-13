;;; Initial setup
;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
;; Install straight
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Make sure packages are installed
(setq use-package-always-ensure t)
(require 'use-package)
(setq use-package-always-ensure t)

(load "~/.emacs.scratch/funcs.el")
(load "~/.emacs.scratch/hooks.el")


;;; Dashboard for a nicer startup.
(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents  . 5)
                          (bookmarks . 5)
                          (projects . 5)
                          (agenda . 5)
                          (registers . 5))
        dashboard-set-heading-icons t
        dashboard-set-file-icons t
        dashboard-center-content t))
(use-package page-break-lines
  :straight (:host github :repo "purcell/page-break-lines"))
;; (use-package 
;;   :config
;;   (turn-on-page-break-lines-mode))
;; If running emacs GUI, use a banner.
(when (display-graphic-p)
  (setq dashboard-startup-banner 'logo))



;; Less typing == Happines
(defalias 'yes-or-no-p 'y-or-n-p)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

(menu-bar-mode -1)            ; Disable the menu bar

;; Disable this annoying effect
(setq visible-bell nil)

;; (set-face-attribute 'default nil :font "JetBrains Mono" :height 90)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))


;;; General User Interface
(global-display-line-numbers-mode)
(column-number-mode)
(setq display-line-numbers-type 'relative)

;; Remember to M-x all-the-icons-install-fonts
(use-package all-the-icons)
;;; Selection, completion and help
(use-package company
  :config
  (dolist (mode '(python-mode-hook
                  c++-mode-hook
                  emacs-lisp-mode-hook
                  elixir-mode-hook))
    (add-hook mode 'company-mode))
  (setq company-tooltip-limit 10)
  (setq company-show-numbers t)
  (setq company-backends '(company-capf
                           company-keywords
                           company-semantic
                           company-files
                           company-etags
                           company-elisp
                           company-clang
                           company-jedi
                           company-cmake
                           company-yasnippet))
  :custom 
  (company-idle-delay 0.1))
(use-package company-box
  :config
  (add-hook 'company-mode 'company-box))
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
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
  (setq ivy-height-alist
        '((counsel-evil-registers . 15)
          (counsel-yank-pop . 15)
          (counsel-git-log . 15)))
  (setq ivy-height 25)
  (setq ivy-re-builders-alist
        '((t . ivy--regex-plus)))
  (setq ivy-initial-inputs-alist nil)
  (ivy-mode 1))
(use-package yasnippet
  :config
  (setq yas-also-auto-indent-first-line t))
(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.2)
  (which-key-setup-minibuffer))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))
(use-package yasnippet
  :config
  (setq yas-also-auto-indent-first-line t))

;;; Visual improvements
(use-package all-the-icons-dired
  :config
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))
(use-package treemacs-all-the-icons)
(use-package all-the-icons-ivy
  :init (add-hook 'after-init-hook 'all-the-icons-ivy-setup))
(use-package ivy-rich
  :config
  (ivy-rich-mode 1)
  (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line))
(use-package all-the-icons-ivy-rich
  :after ivy-rich
  :init
  (all-the-icons-ivy-rich-mode 1))
(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 35)))
(use-package doom-themes
  :init (load-theme 'doom-palenight t))
(use-package scroll-on-jump)
;;; Keybindings and navigation
;; Evil 
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump t)
  (setq evil-want-C-u-delete t)
  (setq evil-kill-on-visual-paste nil)
  (setq evil-shift-width 2)
  :hook (evil-mode . hooks//evil-hook)
  :config
  (evil-mode 1)
  (turn-on-evil-mode)

  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))
(use-package evil-commentary
  :after evil-collection)
(use-package evil-surround
  :after evil-commentary
  :config
  (global-evil-surround-mode 1))
(use-package evil-snipe
  :config
  (evil-snipe-mode)
  (evil-snipe-override-mode 1))
(use-package evil-matchit
  :config
  (add-hook 'prog-mode-hook 'evil-matchit-mode))
(setq org-format-latex-options
      '(:foreground default
                    :background default
                    :scale 1.5
                    :html-foreground "Black"
                    :html-background "Transparent"
                    :html-scale 1.5
                    :matchers ("begin" "$1" "$" "$$" "\\(" "\\[")))
(use-package undo-tree
  :config
  (global-undo-tree-mode)
  (add-hook 'evil-mode-hook
            'undo-tree-mode))
;; Ace
(use-package ace-window)
(use-package hydra)
(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))
(defhydra hydra-flycheck
  (:pre (flycheck-list-errors)
        :post (quit-windows-on "*Flycheck errors*")
        :hint nil)
  "Errors"
  ("f" flycheck-error-list-set-filter "Filter")
  ("j" flycheck-next-error "Next")
  ("k" flycheck-previous-error "Previous")
  ("gg" flycheck-first-error "First")
  ("G" (progn (goto-char (point-max)) (flycheck-previous-error)) "Last")
  ("q" nil))
;; General and keybinds definition
(use-package general)
(general-define-key
 "C-M-b" 'counsel-switch-buffer)

(general-create-definer general//leader-key
  :keymaps '(normal insert visual emacs)
  :prefix "SPC"
  :global-prefix "C-SPC")
(general//leader-key
  "c" '(:ignore t :which-key "Code"))
;; Insert something
(general//leader-key
  "i" '(:ignore t :which-key "Insert...")
  "ir" '(counsel-evil-registers :which-key "Evil Register"))
;; Magit commands
(general//leader-key
  "g" '(:ignore t :which-key "Magit...")
  "gg" '(magit-status :which-key "Status")
  "gc" '(magit-checkout :which-key "Checkout")
  "gb" '(magit-branch-checkout :which-key "Branch Checkout")
  "gf" '(magit-file-checkout :which-key "File Checkout"))

;; Help commands
(general//leader-key
  "h" '(:ignore t :which-key "Help...")
  "hf" '(counsel-describe-function :which-key "Function")
  "hp" '(helpful-at-point :which-key "(at) Point")
  "hv" '(counsel-describe-variable :which-key "Variable")
  "hk" '(helpful-key  :which-key "Variable"))
;; Project management
(general//leader-key
  "p" '(:ignore t :which-key "Projectile")
  "pr" '(projectile-run-project :which-key "Run Project")
  "pc" '(projectile-compile-project :which-key "Switch project")
  "pa" '(projectile-add-known-project :which-key "Add project")
  "pp" '(counsel-projectile-switch-project :which-key "Switch project")
  "pf" '(counsel-projectile-find-file :which-key "Open Project File"))

;; Eval something
(general//leader-key
  "e" '(:ignore t :which-key "Eval...")
  "el" '(eval-last-sexp :which-key "Last sexp")
  "eb" '(eval-buffer :which-key "Buffer"))
;; File commands
(general//leader-key
  "f" '(:ignore t :which-key "Files")
  "ff" '(counsel-find-file :which-key "Open a file")
  "fr" '(counsel-recentf :which-key "Open a recent file"))
;; Dired commands
(general//leader-key
  "d" '(:ignore t :which-key "Dired")
  "dp" '(projectile-dired :which-key "Dired Current Project")
  "dj" '(dired-jump :which-key "Open dired on the current dir."))
;; Buffer commands
(general//leader-key
  "b" '(:ignore t :which-key "Buffers")
  "bs" '(ivy-switch-buffer :which-key "Switch buffers")
  "br" '(revert-buffer-quick :which-key "Revert buffer")
  "bp" '(counsel-projectile-switch-to-buffer :which-key "Switch buffer projects")
  "bk" '(kill-current-buffer :which-key "Kill current buffer")
  "bn" '(funcs//new-buffer :which-key "New buffer")
  "bl" '(evil-switch-to-windows-last-buffer :which-key "Switch to last buffer")
  "be" '(buffer-expose :wich-key "Grid buffer view")
  "bt" '(hydra-text-scale/body :wich-key "Buffer Text Size"))

;; Search commands
(general//leader-key
  "s" '(:ignore t :which-key "Search")
  "ss" '(swiper  :which-key "Search Buffer")
  "sp" '(counsel-projectile-rg :which-key "Search Current Project")
  "sm" '(counsel-evil-marks :which-key "Evil Marks")
  "si" '(counsel-imenu :which-key "Symbol"))

;; Open something
(general//leader-key
  "o"'(:ignore t :which-key "Open...")
  "ot"'(treemacs :which-key "Treemacs")
  "ov"'(vterm :which-key "VTerm")
  "oe"'(eshell :which-key "Eshell"))

;; Window management commands
(general//leader-key
  "ww" '(ace-window :which-key "Cycle")
  "wh" '(evil-window-left :which-key "Left")
  "wl" '(evil-window-right :which-key "Right")
  "wj" '(evil-window-down :which-key "Right")
  "wk" '(evil-window-up :which-key "Right"))



;;; Programming
;; General 
(use-package flycheck
  :config 
  (add-hook 'c++-mode-hook #'flycheck-mode))
(setq-default indent-tabs-mode nil)
(use-package tree-sitter
  :config
  (add-hook 'prog-mode-hook
            'hooks//tree-sitter-hook))
(use-package tree-sitter-langs
  :after tree-sitter)
(setq c-default-style "stroustrup")
(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))
(use-package highlight-indent-guides
  :config
  (setq highlight-indent-guides-method 'character)
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode))
(use-package projectile
  :diminish projectile-mode
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (setq projectile-switch-project-action #'projectile-dired)
  :config
  (projectile-mode))

(use-package counsel-projectile
  :after projectile
  :config (counsel-projectile-mode)
  (use-package magit
    :commands (magit-status magit-get-current-branch)))
;; Treemacs
(load "~/emacs.scratch/treemacs.el")
;; C++
(add-hook 'c++-mode-hook 'lsp)
(setq-default c-basic-offset 4)
;; Elisp
(use-package aggressive-indent
  :config
  (add-hook 'emacs-lisp-mode-hook 'hooks//aggressive-indent-hook))
;; Elixir
(add-hook 'prog-mode 'hooks//prog-mode-hook)
(use-package elixir-yasnippets)
;; Fork of alchemist that does not use company
(straight-use-package '(alchemist
                        :host github :repo "fkrause98/alchemist.el"))
;; Python
(use-package elpy
  :config
  (add-hook 'python-mode-hook #'elpy-enable)
  (add-hook 'elpy-mode-hook #'(lambda () (highlight-indentation-mode -1)))
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
;; Javascript
(use-package js2-mode
  :config
  (add-hook 'js-mode-hook #'(progn
                              (js2-minor-mode)
                              (js2-imenu-extras-setup)
                              (js2-imenu-extras-mode))))
;; Template editing
(use-package emmet-mode)
(use-package web-mode)
(use-package company-web)
(add-hook 'web-mode #'(lambda ()
                        (emmet-mode)
                        (company-web)))
;; LSP
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (elixir-mode . lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  (setq lsp-lens-enable t
        lsp-eldoc-enable-hover nil
        lsp-ui-sideline-enable nil)
  :config
  (lsp-enable-which-key-integration t)
  (setq exec-path (append exec-path '("/home/francisco/elixir-ls/release")))
  (add-hook 'lsp-mode-hook 'yas-minor-mode))
(use-package lsp-ivy)
(use-package dap-mode)
(use-package lsp-treemacs
  :after lsp)
(use-package lsp-ivy)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(display-line-numbers-type 'relative)
 '(evil-undo-system 'undo-tree)
 '(global-display-line-numbers-mode t)
 '(package-selected-packages
   '(evil-snipe dashboard highlight-indent-guides higlight-indent-guides evil-surround ace-window expand-region tree-sitter-langs all-the-icons-ivy evil-commentary evil-commentary-mode forge evil-magit magit counsel-projectile projectile which-key use-package rainbow-delimiters ivy-rich hydra helpful general evil-collection doom-themes doom-modeline counsel command-log-mode))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "JetBrains Mono" :foundry "JB" :slant normal :weight normal :height 98 :width normal)))))

;; Utils
(straight-use-package '(apheleia :host github :repo "raxod502/apheleia"))
(apheleia-global-mode +1)
(straight-use-package
 '(auto-sudoedit :host github :repo "ncaq/auto-sudoedit"))
(auto-sudoedit-mode 1)
(use-package vterm
  :config 
  (add-hook 'vterm-mode-hook #'display-line-numbers-mode)
  (setq vterm-shell "/usr/bin/fish"))

;; Disable line numbers for some modes
(dolist (mode '(term-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook
                vterm-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))
