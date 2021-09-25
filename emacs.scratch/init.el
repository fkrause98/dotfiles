(load "~/.emacs.scratch/funcs.el")


;; Less typing == Happines
(defalias 'yes-or-no-p 'y-or-n-p)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

(menu-bar-mode -1)            ; Disable the menu bar

;; Disable this annoying effect
(setq visible-bell nil)

;;(set-face-attribute 'default nil :font "Fira Code Retina" :height 120)
(set-face-attribute 'default nil :font "JetBrains Mono" :height 120)

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

;; Get packages from source
(unless (package-installed-p 'quelpa)
  (with-temp-buffer
    (url-insert-file-contents "https://raw.githubusercontent.com/quelpa/quelpa/master/quelpa.el")
    (eval-buffer)
    (quelpa-self-upgrade)))


(setq use-package-always-ensure t)

(global-display-line-numbers-mode)
(column-number-mode)
(setq display-line-numbers-type 'relative)
(defun toggle-lines ()
  (interactive)
  (if (eq display-line-numbers 'relative)
      (setq display-line-numbers t)
      (setq display-line-numbers 'relative)))

;; Disable line numbers for some modes
(dolist (mode '(term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package command-log-mode)

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
  (ivy-mode 1))
(setq ivy-height 20)
(global-set-key (kbd "C-M-b") 'counsel-switch-buffer)
;; NOTE: The first time you load your configuration on a new machine, you'll
;; need to run the following command interactively so that mode line icons
;; display correctly:
;;
;; M-x all-the-icons-install-fonts

(use-package all-the-icons)
(use-package all-the-icons-ivy
  :init (add-hook 'after-init-hook 'all-the-icons-ivy-setup))

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 35)))

(use-package doom-themes
  :init (load-theme 'doom-palenight t))


(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.5))
(which-key-setup-minibuffer)

(use-package ivy-rich
  :config
  (ivy-rich-mode 1)
  (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))

(setq ivy-initial-inputs-alist nil)

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))



(defun evil//evil-hook()
  (dolist (mode '(custom-mode
		  eshell-mode
		  git-rebase-mode
		  erc-mode
		  circe-server-mode
		  circe-query-mode
		  sauron-mode
		  term-mode))))
(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump t)
  (setq evil-want-C-u-delete t)
  :hook (evil-mode . evil//evil-hook)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))
(evil-mode 1)
(turn-on-evil-mode)
(add-hook 'evil-mode-hook
          'undo-tree-mode)

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
(setq org-format-latex-options
      '(:foreground default
        :background default
        :scale 1.5
        :html-foreground "Black"
        :html-background "Transparent"
        :html-scale 1.5
        :matchers ("begin" "$1" "$" "$$" "\\(" "\\[")))

(use-package hydra)
(use-package ace-window)

(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))
(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (setq projectile-switch-project-action #'projectile-dired))
(use-package counsel-projectile
  :after projectile
  :config (counsel-projectile-mode))

;;(rune/leader-keys
;;  "ts" '(hydra-text-scale/body :which-key "scale text"))
(use-package magit
  :commands (magit-status magit-get-current-branch))
(use-package forge)
(use-package general)

(general-define-key
  "C-M-b" 'counsel-switch-buffer)

(general-create-definer general//leader-key
:keymaps '(normal insert visual emacs)
:prefix "SPC"
 :global-prefix "C-SPC")


(general//leader-key
  "i" '(:ignore t :which-key "Insert...")
  "ir" '(counsel-evil-registers :which-key "Evil Register")
  "g" '(:ignore t :which-key "Magit...")
  "gg" '(magit-status :which-key "Status")
  "gc" '(magit-checkout :which-key "Checkout")
  "gb" '(magit-branch-checkout :which-key "Branch Checkout")
  "gf" '(magit-file-checkout :which-key "File Checkout")
 "e" '(:ignore t :which-key "Eval...")
 "el" '(eval-last-sexp :which-key "Last sexp")
 "eb" '(eval-buffer :which-key "Buffer")
 "f" '(:ignore t :which-key "Files")
 "ff" '(counsel-find-file :which-key "Open a file")
 "fr" '(counsel-recentf :which-key "Open a recent file")
 "d" '(:ignore t :which-key "Dired")
 "dp" '(projectile-dired :which-key "Dired Current Project")
 "dj" '(dired-jump :which-key "Open dired on the current dir.")
 "b" '(:ignore t :which-key "Buffers")
 "bs" '(counsel-switch-buffer :which-key "Switch buffers")
 "br" '(revert-buffer-quick :which-key "Revert buffer")
 "bp" '(counsel-projectile-switch-to-buffer :which-key "Switch buffer projects")
 "bk" '(kill-current-buffer :which-key "Kill current buffer")
 "bn" '(funcs//new-buffer :which-key "New buffer")
 "bl" '(evil-switch-to-windows-last-buffer :which-key "Switch to last buffer")
 "be" '(buffer-expose :wich-key "Grid buffer view")
 "s" '(:ignore t :which-key "Search")
 "ss" '(swiper  :which-key "Search Buffer")
 "sp" '(counsel-projectile-ag :which-key "Search Current Project")
 "sm" '(counsel-evil-marks :which-key "Evil Marks")
 "p" '(:ignore t :which-key "Projectile")
 "pr" '(projectile-run-project :which-key "Run Project")
 "pc" '(projectile-compile-project :which-key "Switch project")
 "pp" '(counsel-projectile-switch-project :which-key "Switch project")
 "pf" '(counsel-projectile-find-file :which-key "Open Project File ")
 "pa"'(projectile-add-known-project :which-key "Add project")
 "w" '(:ignore t :which-key "Window...")
 "ww" '(ace-window :which-key "Switch"))


(use-package tree-sitter)
(use-package tree-sitter-langs
  :after tree-sitter)
(add-hook 'prog-mode-hook
	    #'(lambda ()
		(when (funcs//tree-sitter-has-lang major-mode)
                 (tree-sitter-hl-mode))))
  
(use-package expand-region
  :bind ("C-=" . er/expand-region))
(setq-default c-basic-offset 4)
(setq c-default-style "stroustrup")

(use-package rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(use-package highlight-indent-guides)
(setq highlight-indent-guides-method 'character)
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(setq-default indent-tabs-mode nil)
(use-package undo-tree)
(use-package ivy-rich)
(use-package ace-window)
(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents  . 5)
                        (bookmarks . 5)
                        (projects . 5)
                        (agenda . 5)
                        (registers . 5))))
(straight-use-package
 '(buffer-expose :type git :host github :repo "clemera/buffer-expose"))
(use-package scroll-on-jump)
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
(global-set-key (kbd "<C-M-prior>") (scroll-on-jump-interactive 'diff-hl-previous-hunk))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-undo-system 'undo-tree)
 '(package-selected-packages
   '(evil-snipe dashboard highlight-indent-guides higlight-indent-guides evil-surround ace-window expand-region tree-sitter-langs all-the-icons-ivy evil-commentary evil-commentary-mode forge evil-magit magit counsel-projectile projectile which-key use-package rainbow-delimiters ivy-rich hydra helpful general evil-collection doom-themes doom-modeline counsel command-log-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; (defhydra hydra-flycheck
;;     (:pre (flycheck-list-errors)
;;      :post (quit-windows-on "*Flycheck errors*")
;;      :hint nil)
;;   "Errors"
;;   ("f" flycheck-error-list-set-filter "Filter")
;;   ("j" flycheck-next-error "Next")
;;   ("k" flycheck-previous-error "Previous")
;;   ("gg" flycheck-first-error "First")
;;   ("G" (progn (goto-char (point-max)) (flycheck-previous-error)) "Last")
;;   ("q" nil))
;; (defhydra hydra-window (:color red
;;                                :hint nil)
;;   "
;;  Split: _v_ert _x_:horz
;; Delete: _o_nly  _da_ce  _dw_indow  _db_uffer  _df_rame
;;   Move: _s_wap
;; Frames: _f_rame new  _df_ delete
;;   Misc: _m_ark _a_ce  _u_ndo  _r_edo"
;;   ("h" windmove-left)
;;   ("j" windmove-down)
;;   ("k" windmove-up)
;;   ("l" windmove-right)
;;   ("H" hydra-move-splitter-left)
;;   ("J" hydra-move-splitter-down)
;;   ("K" hydra-move-splitter-up)
;;   ("L" hydra-move-splitter-right)
;;   ("|" (lambda ()
;;          (interactive)
;;          (split-window-right)
;;          (windmove-right)))
;;   ("_" (lambda ()
;;          (interactive)
;;          (split-window-below)
;;          (windmove-down)))
;;   ("v" split-window-right)
;;   ("x" split-window-below)
;;                                         ;("t" transpose-frame "'")
;;   ;; winner-mode must be enabled
;;   ("u" winner-undo)
;;   ("r" winner-redo) ;;Fixme, not working?
;;   ("o" delete-other-windows :exit t)
;;   ("a" ace-window :exit t)
;;   ("f" new-frame :exit t)
;;   ("s" ace-swap-window)
;;   ("da" ace-delete-window)
;;   ("dw" delete-window)
;;   ("db" kill-this-buffer)
;;   ("df" delete-frame :exit t)
;;   ("q" nil)
;;                                         ;("i" ace-maximize-window "ace-one" :color blue)
;;                                         ;("b" ido-switch-buffer "buf")
;;   ("m" headlong-bookmark-jump))
